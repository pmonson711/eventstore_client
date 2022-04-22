(lang dune 3.0)
(cram enable)

(name eventstore_client)

(generate_opam_files true)
(version unreleased)

(source
  (github pmonson711/eventstore_client))

(authors "Paul Monson")

(maintainers "Paul Monson")

(license MIT)

; (documentation https://url/to/documentation)

(package
 (name eventstore_client)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
   (ocaml (>= 4.08))
   (dune (>= 2.0))
   ;; http2
   (piaf (>= 0.1.0))
   ;; json
   ;; Protobuff types
   (ocaml-protoc-plugin (>= 4.2.0))
   ;; Derivings
   (ppx_deriving (>= 5.2.1))
   (ppx_deriving_yojson (>= 3.6.1))
   ;; Testing
   (alcotest (and :with-test (>= 1.5.0)))
   (alcotest-lwt (and :with-test (>= 1.5.0)))
 )
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
