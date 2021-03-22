-module(service_utils).

-export([normalize_service_args/3]).

normalize_service_args(Term, Country, Language) ->
    T = http_uri:encode(Term),
    C = string:lowercase(atom_to_list(Country)),
    L = string:uppercase(atom_to_list(Language)),
    Hl = C ++ "-" ++ L,
    {T, C, L, Hl}.
