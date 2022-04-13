module T = Operations.Event_store.Client.Operations

module StartScavenge = struct
  module Req = T.StartScavengeReq
  module Resp = T.ScavengeResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Operations.startScavenge
end

module Stopcavenge = struct
  module Req = T.StopScavengeReq
  module Resp = T.ScavengeResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Operations.stopScavenge
end

module Shutdown = struct
  module Req = Shared.Event_store.Client.Empty
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Operations.shutdown
end

module SetNodePriority = struct
  module Req = struct
    type t = int (* TOOD review*)
  end

  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Operations.setNodePriority
end

module RestartPersistentSubscription = struct
  module Req = Shared.Event_store.Client.Empty
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Operations.restartPersistentSubscriptions
end

module ResignNode = struct
  module Req = Shared.Event_store.Client.Empty
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Operations.resignNode
end

module MergeIndexes = struct
  module Req = Shared.Event_store.Client.Empty
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Operations.mergeIndexes
end
