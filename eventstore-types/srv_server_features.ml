module T = Serverfeatures.Event_store.Client

module GetSupportedMethods = struct
  module Req = Shared.Event_store.Client.Empty
  module Resp = T.Server_features.SupportedMethods

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions
      T.Server_features.ServerFeatures.getSupportedMethods
end
