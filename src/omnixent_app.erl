%%%-------------------------------------------------------------------
%% @doc omnixent public API
%% @end
%%%-------------------------------------------------------------------

-module(omnixent_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    application:ensure_all_started(hackney),
    ets:new(service_cache, [set, named_table, public]),
    Dispatch = cowboy_router:compile([{'_',
                                       [{"/", webserver_index_page, []},
                                        {"/api/v1/public",
                                         webserver_api_v1_public,
                                         []}]}]),
    {ok, _} = cowboy:start_clear(http,
                                 [{port, 8818}],
                                 #{env => #{dispatch => Dispatch}}),
    omnixent_sup:start_link().

stop(_State) -> ok = cowboy:stop_listener(http).

%% internal functions

