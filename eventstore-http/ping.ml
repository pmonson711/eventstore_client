type t =
  { msg_type_id: int [@key "msgTypeId"]
  ; text: string
  }
[@@deriving yojson { strict= false }, show]

exception MalformedPingBody of string

let get_string = Req.get_body_at_path "ping"
let as_ping = Req.of_yojson ~f:of_yojson
let get_as_ping = Req.get_as ~f_get:get_string ~f_map:as_ping
