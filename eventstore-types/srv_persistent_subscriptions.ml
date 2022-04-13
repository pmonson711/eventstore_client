module T = Persistent.Event_store.Client

module Create = struct
  module Req = T.Persistent_subscriptions.CreateReq
  module Resp = T.Persistent_subscriptions.CreateResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Persistent_subscriptions.PersistentSubscriptions.create
end

module Update = struct
  module Req = T.Persistent_subscriptions.UpdateReq
  module Resp = T.Persistent_subscriptions.UpdateResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Persistent_subscriptions.PersistentSubscriptions.update
end

module Delete = struct
  module Req = T.Persistent_subscriptions.DeleteReq
  module Resp = T.Persistent_subscriptions.DeleteReq

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Persistent_subscriptions.PersistentSubscriptions.delete
end

module Read = struct
  module Req = T.Persistent_subscriptions.ReadReq
  module Resp = T.Persistent_subscriptions.ReadResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Persistent_subscriptions.PersistentSubscriptions.read
end

module GetInfo = struct
  module Req = T.Persistent_subscriptions.GetInfoReq
  module Resp = T.Persistent_subscriptions.GetInfoResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Persistent_subscriptions.PersistentSubscriptions.getInfo
end

module ReplayParked = struct
  module Req = T.Persistent_subscriptions.ReplayParkedReq
  module Resp = T.Persistent_subscriptions.ReplayParkedResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Persistent_subscriptions.PersistentSubscriptions.replayParked
end

module List = struct
  module Req = T.Persistent_subscriptions.ListReq
  module Resp = T.Persistent_subscriptions.ListResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Persistent_subscriptions.PersistentSubscriptions.list
end

module RestartSubsystem = struct
  module Req = Shared.Event_store.Client.Empty
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Persistent_subscriptions.PersistentSubscriptions.restartSubsystem
end
