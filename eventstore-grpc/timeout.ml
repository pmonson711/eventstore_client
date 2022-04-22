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
