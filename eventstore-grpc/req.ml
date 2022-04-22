type config =
  { grpc_timeout: Timeout.t option
  ; content_type: Content_type.t option
  ; grpc_encoding: Content_coding.t list
  ; grpc_accept_encoding: Content_coding.t list
  ; eventstore_config: Eventstore_config.t
  ; poster:
         ?config:Piaf.Config.t
      -> ?headers:(string * string) list
      -> ?body:Piaf.Body.t
      -> Uri.t
      -> (Piaf.Response.t, Piaf.Error.t) Lwt_result.t
  }

let with_default_grpc c =
  { content_type= Some Proto
  ; grpc_timeout= None
  ; grpc_encoding= [ Identity ]
  ; grpc_accept_encoding= [ Identity; Deflate; Gzip ]
  ; eventstore_config= c
  ; poster= Piaf.Client.Oneshot.post
  }

let as_headers config =
  let maybe_append ~f key optional_value headers =
    match optional_value with
    | Some value -> (key, f value) :: headers
    | None -> headers
  in
  let maybe_append_list ~f key list_value headers =
    match list_value with
    | [] -> headers
    | lst -> (key, String.concat "," @@ List.map f lst) :: headers
  in
  let maybe_add_timeout = maybe_append ~f:Timeout.string_of "grpc-timeout" in
  let maybe_add_content_type =
    maybe_append ~f:Content_type.string_of "content-type"
  in
  let maybe_add_encoding =
    maybe_append_list ~f:Content_coding.string_of "grpc-encoding"
  in
  let maybe_add_accept_encoding =
    maybe_append_list ~f:Content_coding.string_of "grpc-accept-encoding"
  in
  let with_trailers headers = ("te", "trailers") :: headers in
  []
  |> maybe_add_content_type config.content_type
  |> with_trailers
  |> maybe_add_timeout config.grpc_timeout
  |> maybe_add_encoding config.grpc_encoding
  |> maybe_add_accept_encoding config.grpc_accept_encoding
  |> List.rev

type grpc_response =
  { status: Grpc_status.t
  ; body: string
  }
[@@deriving show]

let post_body (config : config) body =
  let open Piaf in
  let open Lwt_result.Syntax in
  let es_config = config.eventstore_config in
  let headers = config |> as_headers in
  let authed_body, authed_uri =
    match es_config.req_auth with
    | Some (Basic _) -> (body, es_config.server_uri)
    | None -> (body, es_config.server_uri)
    | Some (Other other) -> (
        match other.with_http_body with
        | Some with_http_body ->
            with_http_body ~user_name:other.user_name ~password:other.password
              ~body es_config.server_uri
        | None -> (body, es_config.server_uri))
  in
  let* response =
    config.poster ~config:es_config.http_config ~body:authed_body ~headers
      authed_uri
  in
  let+ body =
    if Status.is_successful response.status then Body.to_string response.body
    else
      let message = Status.to_string response.status in
      Lwt.return (Error (`Msg message))
  in
  let status_code =
    Grpc_status.code_of_string
    @@ Piaf.Headers.get_exn response.headers "grpc-status"
  in
  let status_message = Headers.get response.headers "grpc-message" in
  let status =
    match (status_code, status_message) with
    | Some code, Some message -> Grpc_status.make ~message code
    | Some code, None -> Grpc_status.make code
    | None, _ -> Grpc_status.make ~message:"No code found in response" Unknown
  in
  Logs.info (fun m -> m "[response_message= %s]" (Grpc_status.show status)) ;
  { status; body }

let post_service_method service meth_name ?(grpc_config = with_default_grpc)
    (config : Eventstore_config.t) body =
  let open Eventstore_config in
  let path = service ^ "/" ^ meth_name in
  let grpc_config = config |> with_server_path path |> grpc_config in
  let response = post_body grpc_config body in
  response

let string_to_body = Piaf.Body.of_string
