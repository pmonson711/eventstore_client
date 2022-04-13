module T = Projections.Event_store.Client

module Create = struct
  module Req = T.Projections.CreateReq
  module Resp = T.Projections.CreateResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Projections.Projections.create
end

module Update = struct
  module Req = T.Projections.UpdateReq
  module Resp = T.Projections.UpdateResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Projections.Projections.update
end

module Delete = struct
  module Req = T.Projections.DeleteReq
  module Resp = T.Projections.DeleteReq

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Projections.Projections.delete
end

module Statistics = struct
  module Req = T.Projections.StatisticsReq
  module Resp = T.Projections.StatisticsResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Projections.Projections.statistics
end

module Disable = struct
  module Req = T.Projections.DisableReq
  module Resp = T.Projections.DisableResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Projections.Projections.disable
end

module Enable = struct
  module Req = T.Projections.EnableReq
  module Resp = T.Projections.EnableResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Projections.Projections.enable
end

module Reset = struct
  module Req = T.Projections.ResetReq
  module Resp = T.Projections.ResetResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Projections.Projections.reset
end

module State = struct
  module Req = T.Projections.StateReq
  module Resp = T.Projections.StateResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Projections.Projections.state
end

module Result = struct
  module Req = T.Projections.ResultReq
  module Resp = T.Projections.ResultResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Projections.Projections.result
end

module RestartSubsystem = struct
  module Req = Shared.Event_store.Client.Empty
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Projections.Projections.restartSubsystem
end
