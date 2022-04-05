(lang dune 3.0)

(name eventstore_client)

(generate_opam_files true)

; (source
; (github username/reponame))

(authors "Paul Monson")

(maintainers "Paul Monson")

; (license LICENSE)

; (documentation https://url/to/documentation)

(package
 (name eventstore_client)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
   (ocaml (>= 4.08))
   (dune (>= 2.0))
   (uri (>= 4.2.0))
   (ocaml-protoc (>= 2.1))
   (h2 (>= 0.8.0)))
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
