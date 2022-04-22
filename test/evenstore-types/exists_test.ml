let test_name = "Exists"
let the_truth () = Alcotest.(check bool) "the truth" true true

let case =
  let open Alcotest in
  (test_name, [ test_case "the truth" `Quick the_truth ])
