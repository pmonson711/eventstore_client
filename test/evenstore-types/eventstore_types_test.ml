let () =
  let open Alcotest in
  run "Types_test" [ Exists_test.case ]
