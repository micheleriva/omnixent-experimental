-module(webserver_api_v1_public).

-export([init/2]).

init(Req0, Opts) ->
    Method = cowboy_req:method(Req0),
    #{service := Service} = cowboy_req:match_qs([{service,
                                                  [],
                                                  undefined}],
                                                Req0),
    #{term := Term} = cowboy_req:match_qs([{term,
                                            [],
                                            undefined}],
                                          Req0),
    #{language := Language} =
        cowboy_req:match_qs([{language, [], undefined}], Req0),
    #{country := Country} = cowboy_req:match_qs([{country,
                                                  [],
                                                  undefined}],
                                                Req0),
    Req = handle_request(Method,
                         binary_to_atom(Service),
                         binary_to_list(Term),
                         binary_to_atom(Language),
                         binary_to_atom(Country),
                         Req0),
    {ok, Req, Opts}.

handle_request(<<"GET">>, undefined, _, _, _, Req) ->
    cowboy_req:reply(401,
                     #{<<"content-type">> => <<"application/json">>},
                     <<"{\"success\": false, \"reason\": \"Missing "
                       "required 'service' parameter\"}">>,
                     Req);
handle_request(<<"GET">>, _, undefined, _, _, Req) ->
    cowboy_req:reply(401,
                     #{<<"content-type">> => <<"application/json">>},
                     <<"{\"success\": false, \"reason\": \"Missing "
                       "required 'term' parameter\"}">>,
                     Req);
handle_request(<<"GET">>, Service, Term, Language,
               Country, Req) ->
    Data = call_service:request(Service,
                                Term,
                                Country,
                                Language),
    {_, _, Expiration} = Data,
    ResponseData = api_utils:format_service_response(Data),
    Resp = #{success => true, data => ResponseData,
             expires_in => Expiration},
    JSONResp = jiffy:encode(Resp),
    cowboy_req:reply(200,
                     #{<<"content-type">> => <<"application/json">>},
                     JSONResp,
                     Req);
handle_request(_, _, _, _, _, Req) ->
    %% Method not allowed.
    cowboy_req:reply(405, Req).
