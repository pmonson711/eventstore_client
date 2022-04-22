type basic =
  { user_name: string
  ; password: string option
  }

type other =
  { user_name: string
  ; password: string option
  ; with_auth_http_headers:
      user_name:string -> password:string option -> (string * string) list
  ; with_http_body:
      (   user_name:string
       -> password:string option
       -> ?body:Piaf.Body.t
       -> Uri.t
       -> Piaf.Body.t * Uri.t)
      option
  }

and t =
  | Basic of basic
  | Other of other

let with_basic_http_context (user : basic) =
  let encoded_user =
    String.concat ":" [ user.user_name; Option.value user.password ~default:"" ]
    |> Base64.encode
  in
  match encoded_user with
  | Ok encoded_string ->
      [ ("authorization", String.concat " " [ "Basic"; encoded_string ]) ]
  | Error _err -> []

let with_http_context = function
  | Basic user -> with_basic_http_context user
  | Other { user_name; password; with_auth_http_headers; with_http_body= _ } ->
      with_auth_http_headers ~user_name ~password

let make_basic user_name = Basic { user_name; password= None }

let with_password pass = function
  | Basic basic -> Basic { basic with password= Some pass }
  | Other other -> Other { other with password= Some pass }
