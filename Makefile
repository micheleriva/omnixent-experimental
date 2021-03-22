all: compile eunit 

rebar ?= rebar3
rebar_cmd = $(rebar) $(profile:%=as %)

compile:
	@$(rebar_cmd) compile

clean:
	@$(rebar_cmd) clean

eunit:
	@$(rebar_cmd) do eunit,cover

start: compile
	-@$(rebar_cmd) shell

edoc: profile=edown
edoc:
	@$(rebar_cmd) edoc