-module(utils).

-export([concat_lists/1]).

concat_lists([L]) -> L;
concat_lists([H | T]) -> H + concat_lists(T).
