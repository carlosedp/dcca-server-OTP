%% -------------------------------------------------------------------
%%
%% dccaserver: Erlang OTP Diameter Credit Control Application
%%
%% @author Carlos Eduardo de Paula <carlosedp@gmail.com>
%% @copyright 2015 Carlos Eduardo de Paula
%% @doc Diameter application settings
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

-define(DCCA_APPLICATION_ID, 4).
-define(CCR_INITIAL, ?'CC-REQUEST-TYPE_INITIAL_REQUEST').
-define(CCR_UPDATE, ?'CC-REQUEST-TYPE_UPDATE_REQUEST').
-define(CCR_TERMINATE, ?'CC-REQUEST-TYPE_TERMINATION_REQUEST').
-define(MSISDN, ?'SUBSCRIPTION-ID-TYPE_END_USER_E164').
-define(IMSI, ?'SUBSCRIPTION-ID-TYPE_END_USER_IMSI').
