-module(call_service).

-export([call/4]).

-define(Method, get).

-define(Headers, []).

-define(Payload, <<>>).

-define(Options, []).

call(google, Term, Country, Language) ->
    URL = google:format_uri(Term, Country, Language),
    {ok, _, _, ClientRef} = hackney:request(get,
                                            URL,
                                            [],
                                            <<>>,
                                            []),
    {ok, Body} = hackney:body(ClientRef),
    NormalizedBody = google:extract_body(Body),
    google:collect_values(NormalizedBody);
call(Service, _, _, _) ->
    Error = "Service " ++ Service ++ " is not available",
    {error, Error}.
