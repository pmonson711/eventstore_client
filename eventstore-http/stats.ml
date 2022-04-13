type t = { proc: proc }

and proc =
  { start_time: string [@key "startTime"]
  ; id: int
  ; mem: float
  ; proc_cpu: float [@key "cpu"]
  ; cpu_scaled: float option [@key "cpuScaled"] [@default None]
  ; threads_count: int [@key "threadsCount"]
  ; contentions_rate: float [@key "contentionsRate"]
  ; thrown_exceptions_rate: float [@key "thrownExceptionsRate"]
  ; disk_io: disk_io [@key "diskIo"]
  }

and disk_io =
  { read_bytes: float [@key "readBytes"]
  ; written_bytes: float [@key "writtenBytes"]
  ; read_ops: float [@key "readOps"]
  ; write_ops: float [@key "writeOps"]
  }

and sys =
  { sys_cpu: float [@key "cpu"]
  ; free_mem: float [@key "freeMem"]
  }
[@@deriving yojson { strict= false }, show]

let get_string = Req.get_body_at_path "stats"
let as_stats = Req.of_yojson ~f:of_yojson
let get_as_stats = Req.get_as ~f_get:get_string ~f_map:as_stats
