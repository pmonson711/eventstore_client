EVENTSTORE_TAG=oss-v21.10.2
PROTO_SOURCE=https://raw.githubusercontent.com/EventStore/EventStore/$(EVENTSTORE_TAG)/src/Protos/Grpc/
PROTO_DEST=./types/proto/
CURL=curl
CURL_ARGS=-L

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

.PHONY: fetch_proto
fetch_proto:
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)cluster.proto --output $(PROTO_DEST)cluster.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)code.proto --output $(PROTO_DEST)code.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)gossip.proto --output $(PROTO_DEST)gossip.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)monitoring.proto --output $(PROTO_DEST)monitoring.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)operations.proto --output $(PROTO_DEST)operations.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)persistent.proto --output $(PROTO_DEST)persistent.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)projections.proto --output $(PROTO_DEST)projections.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)serverfeatures.proto --output $(PROTO_DEST)serverfeatures.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)shared.proto --output $(PROTO_DEST)shared.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)status.proto --output $(PROTO_DEST)status.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)streams.proto --output $(PROTO_DEST)streams.proto
	$(CURL) $(CURL_ARGS) $(PROTO_SOURCE)users.proto --output $(PROTO_DEST)users.proto

.PHONY: format
format:
	dune build @fmt --auto-promote

.PHONY: clean
clean:
	dune clean
	rm -Rf _coverage
