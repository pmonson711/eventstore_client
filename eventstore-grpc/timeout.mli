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
