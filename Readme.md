# Erlang Diameter Credit Control Application

This repository contains an example OTP DCCA application server built in Erlang.

To build the modules and diameter dictionaries, use rebar:

    ./rebar3 compile

To start the module in a shell use:

    ./rebar3 shell

Or use the provided Makefile:

    make
    make shell

A release is also available and built with the commands above. To load the application use:

    ./rebar3 release
    ./_build/default/rel/dccaserver/bin/dccaserver console

To create a release and a tar.gz archive for production with erts included:

    ./rebar3 as prod release

    ./_build/prod/rel/dccaserver/bin/dccaserver console
    ./rebar3 as prod tar

## Testing

To test the server, use the client module from project [diameter-dcca](https://github.com/carlosedp/diameter-dcca) or Seagull with included files.

### Client (diameter-dcca)

    erl
    client:start().
    client:test().

### Seagull

Seagull can be used to generate Diameter traffic to the server. The configuration, scenario xml and start scripts are in `test/seagull` dir.

The application can be downloaded from [http://gull.sourceforge.net/doc/](http://gull.sourceforge.net/doc/) and put in the path.


