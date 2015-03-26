all: deps compile

deps:
	escript rebar get-deps

compile:
	@ $(MAKE) -C apps/dccaserver/src/diameter-dict
	escript rebar compile

shell:
	erl -pa deps/*/ebin apps/*/ebin -s startapp start

clean:
	$(MAKE) -C apps/dccaserver/src/diameter-dict clean
	escript rebar clean
