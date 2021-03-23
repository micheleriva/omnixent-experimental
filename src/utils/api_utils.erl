-module(api_utils).

-export([format_service_response/1]).

results_to_binary(Results) ->
    lists:map(fun (X) -> unicode:characters_to_binary(X)
              end,
              Results).

format_service_response(Response) ->
    {_, Resp, _} = Response,
    lists:map(fun (X) ->
                      {Term, LanguageTerm, Results} = X,
                      #{term => unicode:characters_to_binary(Term),
                        languageTerm =>
                            unicode:characters_to_binary(LanguageTerm),
                        results => results_to_binary(Results)}
              end,
              Resp).
