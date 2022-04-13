module Timeout : sig
  type value

  type unit =
    | Hour
    | Minute
    | Second
    | Millisecond
    | Microsecond
    | Nanosecond

  type t = value * unit

  val make_value : int -> value option
  val abbrev_of_unit : unit -> string
  val string_of : t -> string
  val make : int -> unit -> t option
end = struct
  type value = int

  type unit =
    | Hour
    | Minute
    | Second
    | Millisecond
    | Microsecond
    | Nanosecond

  type t = value * unit

  let make_value i = if i > 0 then Some i else None

  let make i u =
    let value = make_value i in
    match value with Some v -> Some (v, u) | None -> None

  let abbrev_of_unit = function
    | Hour -> "H"
    | Minute -> "M"
    | Second -> "S"
    | Millisecond -> "m"
    | Microsecond -> "u"
    | Nanosecond -> "n"

  let string_of (v, u) = Printf.sprintf "%d%s" v (abbrev_of_unit u)
end

module ContentType = struct
  type t =
    | Default
    | Proto
    | Json
    | Other of string

  let base = "application/grpc"
  let base_plus s = Printf.sprintf "%s+%s" base s

  let string_of = function
    | Default -> base
    | Proto -> base_plus "proto"
    | Json -> base_plus "json"
    | Other s -> base_plus s
end

module ContentCoding = struct
  type t =
    | Identity
    | Gzip
    | Deflate
    | Snappy
    | Other of string

  let string_of = function
    | Identity -> "identity"
    | Gzip -> "gzip"
    | Deflate -> "deflate"
    | Snappy -> "snappy"
    | Other s -> s
end

type config =
  { grpc_timeout: Timeout.t option
  ; grpc_encoding: ContentType.t option
  ; grpc_accept_encoding: ContentCoding.t option
  ; eventstore_config: Eventstore_config.t
  }

let with_default_grpc c =
  { grpc_encoding= Some Proto
  ; grpc_timeout= None
  ; grpc_accept_encoding= None
  ; eventstore_config= c
  }

let post_body (config : config) body =
  let open Piaf in
  let open Lwt_result.Syntax in
  let es_config = config.eventstore_config in
  let maybe_append ~f key optional_value headers =
    match optional_value with
    | Some value -> (key, f value) :: headers
    | None -> headers
  in
  let maybe_add_timeout = maybe_append ~f:Timeout.string_of "grpc-timeout" in
  let maybe_add_encoding =
    maybe_append ~f:ContentType.string_of "grpc-encoding"
  in
  let maybe_add_accept_encoding =
    maybe_append ~f:ContentCoding.string_of "grpc-accept-encoding"
  in
  let headers =
    []
    |> maybe_add_timeout config.grpc_timeout
    |> maybe_add_encoding config.grpc_encoding
    |> maybe_add_accept_encoding config.grpc_accept_encoding
  in
  let* response =
    Client.Oneshot.post ~config:es_config.http_config ~body ~headers
      es_config.server_uri
  in
  let+ body =
    if Status.is_successful response.status then Body.to_string response.body
    else
      let message = Status.to_string response.status in
      Lwt.return (Error (`Msg message))
  in
  body

let post_service_method service meth_name ?(grpc_config = with_default_grpc)
    (config : Eventstore_config.t) body =
  let open Eventstore_config in
  let path = service ^ "/" ^ meth_name in
  let grpc_config = config |> with_server_path path |> grpc_config in
  post_body grpc_config body
