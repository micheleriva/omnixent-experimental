-module(pmap).

-export([pmap/2]).

pmap(Function, List) ->
    S = self(),
    Pids = lists:map(fun (El) ->
                             spawn(fun () -> execute(S, Function, El) end)
                     end,
                     List),
    gather(Pids).

execute(Recv, Function, Element) ->
    Recv ! {self(), Function(Element)}.

gather([]) -> [];
gather([H | T]) ->
    receive {H, Ret} -> [Ret | gather(T)] end.
