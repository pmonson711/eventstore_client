module T = Gossip.Event_store.Client.Gossip

module Read = struct
  module Req = Shared.Event_store.Client.Empty
  module Resp = T.ClusterInfo

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Gossip.read
end
