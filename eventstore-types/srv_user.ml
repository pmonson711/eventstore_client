module T = Users.Event_store.Client.Users

module Create = struct
  module Req = T.CreateReq
  module Resp = T.CreateResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.create
end

module Update = struct
  module Req = T.UpdateReq
  module Resp = T.UpdateResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.update
end

module Disable = struct
  module Req = T.DisableReq
  module Resp = T.DisableResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.disable
end

module Enable = struct
  module Req = T.EnableReq
  module Resp = T.EnableResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.enable
end

module Details = struct
  module Req = T.DetailsReq
  module Resp = T.DetailsResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.details
end

module ChangePassword = struct
  module Req = T.ChangePasswordReq
  module Resp = T.ChangePasswordResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.changePassword
end

module ResetPassword = struct
  module Req = T.ResetPasswordReq
  module Resp = T.ResetPasswordResp

  let decode, encode =
    Ocaml_protoc_plugin.Service.make_client_functions T.Users.resetPassword
end
