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
