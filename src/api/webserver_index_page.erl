-module(webserver_index_page).

-export([init/2]).

init(Req0, Opts) ->
    Req = cowboy_req:reply(200,
                           #{<<"content-type">> => <<"text/html">>},
                           <<"<h1>Omnixent</h1>">>,
                           Req0),
    {ok, Req, Opts}.
