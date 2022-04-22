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
