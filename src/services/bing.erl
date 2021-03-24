-module(bing).

-export([extract_body/1, format_uri/3]).

-import(service_utils, [normalize_service_args/3]).

-define(Endpoint, "https://api.bing.com/osjson.aspx").

format_uri(Term, Country, Language) ->
    {T, _, _, Hl} = normalize_service_args(Term,
                                           Country,
                                           Language),
    (?Endpoint) ++ "?query=" ++ T ++ "&mkt=" ++ Hl.

extract_body(Res) ->
    Decoded = jiffy:decode(Res),
    lists:nth(2, Decoded).
