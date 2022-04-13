let get_body (config : Eventstore_config.t) =
  let open Piaf in
  let open Lwt_result.Syntax in
  let* response =
    Client.Oneshot.get ~config:config.http_config config.server_uri
  in
  let+ body =
    if Status.is_successful response.status then Body.to_string response.body
    else
      let message = Status.to_string response.status in
      Lwt.return (Error (`Msg message))
  in
  body

let get_body_at_path path (config : Eventstore_config.t) =
  let open Eventstore_config in
  get_body (config |> with_server_path path)

exception MalformedBody of string

let of_yojson ~f body =
  let open Lwt_result.Syntax in
  let+ yojson = Lwt.return_ok (Yojson.Safe.from_string body) in
  match f yojson with Ok info -> info | Error msg -> raise (MalformedBody msg)

let get_as ~f_get ~f_map config =
  let open Lwt_result.Syntax in
  let* body = f_get config in
  let+ mapped = f_map body in
  mapped
