%% -------------------------------------------------------------------
%%
%% dccaserver: Erlang OTP Diameter Credit Control Application
%%
%% @author Carlos Eduardo de Paula <carlosedp@gmail.com>
%% @copyright 2015 Carlos Eduardo de Paula
%% @doc OCS gateway OTP application
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License. You may obtain
%% a copy of the License at
%%
%% http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied. See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------

-module(ocsgateway_app).
-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    ocsgateway_sup:start_link().

stop(_State) ->
    ok.