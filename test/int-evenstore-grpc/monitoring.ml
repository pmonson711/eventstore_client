let test_name = "Monitoring"

let config =
  let host =
    match Sys.getenv_opt "EVENTSTORE_HOST" with
    | Some host -> host
    | None -> Eventstore_config.default_host
  in
  Eventstore_config.(default |> with_allow_insecure |> with_server_host host)

let monitoring_req =
  let open Eventstore_types.Monitoring.Stats.Req in
  make ~use_metadata:true ()

let can_get_admin_details_is_ok _switch () =
  let open Lwt.Syntax in
  let* make_req =
    let open Eventstore_grpc.Req in
    let open Eventstore_types.Monitoring.Stats in
    Logs.info (fun m -> m "\n[monitoring= %s]" (Req.show monitoring_req)) ;
    let encoded =
      encode monitoring_req |> Ocaml_protoc_plugin.Writer.contents
    in
    Logs.info (fun m -> m "[encoded= %S]" encoded) ;
    post_service_method "event_store.client.monitoring.Monitoring" "Stats"
      config
    @@ Piaf.Body.of_string encoded
  in
  let+ test =
    match make_req with Ok _ -> Lwt.return_true | Error _ -> Lwt.return_false
  in
  Alcotest.(check bool) "get admin request" test true

let case =
  let open Alcotest_lwt in
  (test_name, [ test_case "User_Details" `Quick can_get_admin_details_is_ok ])
