-module(call_service).

-export([call/4]).

-define(Method, get).
-define(Headers, []).
-define(Payload, <<>>).
-define(Options, []).

call(google, Term, Country, Language) ->
    URL = google:format_uri(Term, Country, Language),
    {ok, _, _, ClientRef} = hackney:request(?Method, URL, ?Headers, ?Payload, ?Options),
    {ok, Body} = hackney:body(ClientRef),
    google:collect_values(
        google:extract_body(Body));
call(youtube, Term, Country, Language) ->
    URL = youtube:format_uri(Term, Country, Language),
    {ok, _, _, ClientRef} = hackney:request(?Method, URL, ?Headers, ?Payload, ?Options),
    {ok, Body} = hackney:body(ClientRef),
    youtube:collect_values(
        youtube:extract_body(Body));
call(Service, _, _, _) ->
    Error = "Service " ++ Service ++ " is not available",
    {error, Error}.
