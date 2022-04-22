module T = Users.Event_store.Client.Users

module Create = struct
  module Req = T.CreateReq
  module Resp = T.CreateResp

  let encode, decode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.create
end

module Update = struct
  module Req = T.UpdateReq
  module Resp = T.UpdateResp

  let encode, decode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.update
end

module Disable = struct
  module Req = T.DisableReq
  module Resp = T.DisableResp

  let encode, decode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.disable
end

module Enable = struct
  module Req = T.EnableReq
  module Resp = T.EnableResp

  let encode, decode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.enable
end

module Details = struct
  module Req = T.DetailsReq
  module Resp = T.DetailsResp

  let encode, decode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.details

  let to_req_body a = Ocaml_protoc_plugin.Writer.contents @@ encode a
end

module ChangePassword = struct
  module Req = T.ChangePasswordReq
  module Resp = T.ChangePasswordResp

  let encode, decode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.changePassword
end

module ResetPassword = struct
  module Req = T.ResetPasswordReq
  module Resp = T.ResetPasswordResp

  let encode, decode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.resetPassword
end
