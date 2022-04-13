type t =
  { es_version: string [@key "esVersion"]
  ; state: string
  ; features: features option [@default None]
  ; authentication: authn option [@default None]
  }

and features =
  { projections: bool
  ; user_management: bool [@key "userManagement"]
  ; atom_pub: bool [@key "atomPub"]
  }

and authn =
  { kind: string [@key "type"]
  ; properties: Yojson.Safe.t
  }
[@@deriving yojson { strict= false }, show]

exception MalformedInfoBody of string

let get_string = Req.get_body_at_path "info"
let as_info = Req.of_yojson ~f:of_yojson
let get_as_info = Req.get_as ~f_get:get_string ~f_map:as_info
