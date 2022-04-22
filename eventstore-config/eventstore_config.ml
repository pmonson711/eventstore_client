type t =
  { server_uri: Uri.t
  ; http_config: Piaf.Config.t
  ; req_auth: Req_auth.t option
  }

let get_http_header_context = function
  | Some r -> Req_auth.with_http_context r
  | None -> []

let with_server_host hostname config =
  let updated_server_uri = Uri.with_host config.server_uri (Some hostname) in
  { config with server_uri= updated_server_uri }

let with_server_port port config =
  let updated_server_uri = Uri.with_port config.server_uri (Some port) in
  { config with server_uri= updated_server_uri }

let with_server_scheme scheme config =
  let updated_server_uri = Uri.with_scheme config.server_uri (Some scheme) in
  { config with server_uri= updated_server_uri }

let with_allow_insecure config =
  let updated_http_config =
    { config.http_config with
      allow_insecure= true
    ; http2_prior_knowledge= true
    }
  in
  let updated_scheme =
    match Uri.scheme config.server_uri with
    | Some "https" -> "http"
    | Some other -> other
    | None -> "http"
  in
  { config with http_config= updated_http_config }
  |> with_server_scheme updated_scheme

let with_server_path string config =
  let updated_server_uri = Uri.with_path config.server_uri string in
  { config with server_uri= updated_server_uri }

let with_connect_timeout timeout config =
  let updated_http_config =
    { config.http_config with connect_timeout= timeout }
  in
  { config with http_config= updated_http_config }

let with_basic_user_and_password user pass config =
  let req_auth = Some Req_auth.(make_basic user |> with_password pass) in
  let http_config =
    { config.http_config with
      default_headers= get_http_header_context req_auth
    }
  in
  { config with req_auth; http_config }

let with_password password config =
  let updated_user =
    match config.req_auth with
    | Some req_auth -> Some (req_auth |> Req_auth.with_password password)
    | None -> None
  in
  let http_config =
    { config.http_config with
      default_headers= get_http_header_context updated_user
    }
  in
  { config with req_auth= updated_user; http_config }

let without_req_auth config = { config with req_auth= None }
let default_host = "localhost"

let default =
  let req_auth =
    Some Req_auth.(make_basic "admin" |> with_password "chanegit")
  in
  let server_uri =
    Uri.of_string @@ String.concat "" [ "https://"; default_host; ":2113/" ]
  in
  { server_uri
  ; http_config=
      { Piaf.Config.default with
        enable_http2_server_push= true
      ; default_headers= get_http_header_context req_auth
      }
  ; req_auth
  }

module Logger = Setup_logs
