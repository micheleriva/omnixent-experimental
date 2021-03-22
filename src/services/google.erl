-module(google).

-export([extract_body/1, format_uri/3]).

-import(service_utils, [normalize_service_args/3]).

-define(Endpoint,
        "https://www.google.com/complete/search").

format_uri(Term, Country, Language) ->
    {T, _, _, Hl} = normalize_service_args(Term,
                                           Country,
                                           Language),
    (?Endpoint) ++
        "?client=gws-wiz&q=" ++ T ++ "&hl=" ++ Hl.

extract_body(response) ->
    ResponseWithoutScriptOpening =
        string:replace("window.google.ac.h(", "*", ""),
    ResponseWithoutScriptEnding =
        lists:reverse(tl(lists:reverse(ResponseWithoutScriptOpening))),
    jsone:decode(ResponseWithoutScriptEnding).
