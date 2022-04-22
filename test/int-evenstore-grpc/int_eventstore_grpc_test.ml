let () = Eventstore_config.Logger.setup_log (Some Debug)

let () =
  Lwt_main.run
  @@ Alcotest_lwt.run "Evenstore_Integration_Tests"
       [ Users.case; Monitoring.case ]
