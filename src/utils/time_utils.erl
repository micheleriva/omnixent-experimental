-module(time_utils).

-export([get_timestamp/0]).

-spec get_timestamp() -> integer().

get_timestamp() ->
    {Mega, Sec, Micro} = os:timestamp(),
    (Mega * 1000000 + Sec) * 1000 + round(Micro / 1000).
