type t =
  { server_uri: Uri.t
  ; http_config: Piaf.Config.t
  }

let default =
  { server_uri= Uri.of_string "https://localhost:2113/"
  ; http_config= Piaf.Config.default
  }

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
  let updated_http_config = { config.http_config with allow_insecure= true } in
  { config with http_config= updated_http_config }

let with_server_path string config =
  let updated_server_uri = Uri.with_path config.server_uri string in
  { config with server_uri= updated_server_uri }

let with_connect_timeout timeout config =
  let updated_http_config =
    { config.http_config with connect_timeout= timeout }
  in
  { config with http_config= updated_http_config }

module Logger = Setup_logs
