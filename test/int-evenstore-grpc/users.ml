let test_name = "Users"

let config =
  let host =
    match Sys.getenv_opt "EVENTSTORE_HOST" with
    | Some host -> host
    | None -> Eventstore_config.default_host
  in
  Eventstore_config.(default |> with_allow_insecure |> with_server_host host)

let admin_details_req =
  let open Eventstore_types.Users.Details.Req in
  let options = Options.make ~login_name:"admin" () in
  make ~options ()

let can_get_admin_details_is_ok _switch () =
  let open Lwt.Syntax in
  let* make_req =
    let open Eventstore_grpc.Req in
    let open Eventstore_types.Users.Details in
    Logs.info (fun m -> m "[user= %s]" (Req.show admin_details_req)) ;
    let encoded =
      encode admin_details_req |> Ocaml_protoc_plugin.Writer.contents
    in
    Logs.info (fun m -> m "[encoded= %S]" encoded) ;
    post_service_method "event_store.client.users.Users" "Details" config
    @@ Piaf.Body.of_string encoded
  in
  let+ test =
    match make_req with Ok _ -> Lwt.return_true | Error _ -> Lwt.return_false
  in
  Alcotest.(check bool) "get admin request" test true

let case =
  (* let open Alcotest_lwt in *)
  (test_name, [])
