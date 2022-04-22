module T = Monitoring.Event_store.Client

module Stats = struct
  module Req = T.Monitoring.StatsReq
  module Resp = T.Monitoring.StatsResp

  let encode, decode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Monitoring.Monitoring.stats
end
