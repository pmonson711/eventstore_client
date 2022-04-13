module T = Cluster.Event_store.Cluster

module ViewChange = struct
  module Req = T.ViewChangeRequest
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Elections.viewChange
end

module ViewChangeProof = struct
  module Req = T.ViewChangeProofRequest
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Elections.viewChangeProof
end

module Prepare = struct
  module Req = T.PrepareRequest
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Elections.prepare
end

module PrepareOk = struct
  module Req = T.PrepareOkRequest
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Elections.prepareOk
end

module Proposal = struct
  module Req = T.ProposalRequest
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Elections.proposal
end

module Accept = struct
  module Req = T.AcceptRequest
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Elections.accept
end

module LeaderIsResigning = struct
  module Req = T.LeaderIsResigningRequest
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Elections.leaderIsResigning
end

module LeaderIsResigningOk = struct
  module Req = T.LeaderIsResigningOkRequest
  module Resp = Shared.Event_store.Client.Empty

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Elections.leaderIsResigningOk
end
