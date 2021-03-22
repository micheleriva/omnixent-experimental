%%%-------------------------------------------------------------------
%% @doc omnixent public API
%% @end
%%%-------------------------------------------------------------------

-module(omnixent_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    application:ensure_all_started(hackney),
    omnixent_sup:start_link().

stop(_State) -> ok.

%% internal functions

