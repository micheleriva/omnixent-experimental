-module(youtube).

-export([collect_values/1, extract_body/1, format_uri/3]).

-import(service_utils, [normalize_service_args/3]).

-define(Endpoint, "https://clients1.google.com/complete/search").

format_uri(Term, Country, Language) ->
    {T, _, _, Hl} = normalize_service_args(Term, Country, Language),
    ?Endpoint ++ "?client=youtube&gs_ri=youtube&q=" ++ T ++ "&hl=" ++ Hl.

extract_body(Response) ->
    [_, _, ResponseWithoutScriptOpening] =
        string:replace(Response, "window.google.ac.h(", ""),
    ResponseWithoutScriptEnding =
        lists:reverse(tl(lists:reverse(binary_to_list(ResponseWithoutScriptOpening)))),
    jsone:decode(list_to_binary(ResponseWithoutScriptEnding)).

collect_values(JSONResponse) ->
    [R, _] = JSONResponse,
    lists:map(fun([H | _]) -> binary_to_list(H) end, R).
