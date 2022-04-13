module T = Streams.Event_store.Client

module Read = struct
  module Req = T.Streams.ReadReq
  module Resp = T.Streams.ReadResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Streams.Streams.read
end

module Append = struct
  module Req = T.Streams.AppendReq
  module Resp = T.Streams.AppendResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Streams.Streams.append
end

module Delete = struct
  module Req = T.Streams.DeleteReq
  module Resp = T.Streams.DeleteResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Streams.Streams.delete
end

module Tombstone = struct
  module Req = T.Streams.TombstoneReq
  module Resp = T.Streams.TombstoneResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Streams.Streams.tombstone
end

module BatchAppend = struct
  module Req = T.Streams.BatchAppendReq
  module Resp = T.Streams.BatchAppendResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Streams.Streams.batchAppend
end
