.PHONY: build
build:
	dune build @all -j8

.PHONY: create_switch
create_switch:
	opam switch create . 4.13.1

.PHONY: setup
setup:
	-opam install dune
	-opam install merlin ocamlformat odig utop bisect_ppx
	-dune build @install
	opam install . --deps-only --with-test

.PHONY: watch
watch:
	dune build @all --watch -j8

.PHONY: install
install:
	dune install

.PHONY: test
test:
	dune runtest

.PHONY: watch_test
watch_test:
	dune runtest -w

.PHONY: coverage
coverage:
	dune runtest --instrument-with bisect_ppx --force
	bisect-ppx-report summary --per-file
	bisect-ppx-report html

.PHONY: format
format:
	dune build @fmt --auto-promote

.PHONY: clean
clean:
	dune clean
	rm -Rf _coverage
