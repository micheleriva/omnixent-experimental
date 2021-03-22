-module(google_test).

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

format_uri_test_() ->
    [{"Simple google encoding of term Erlang "
      "for US in english",
      fun () ->
              ?assertEqual((google:format_uri("erlang", us, en)),
                           "https://www.google.com/complete/search?client"
                           "=gws-wiz&q=erlang&hl=us-EN")
      end},
     {"Simple google encoding of term Java "
      "for Italy in italian",
      fun () ->
              ?assertEqual((google:format_uri("erlang", us, en)),
                           "https://www.google.com/complete/search?client"
                           "=gws-wiz&q=java&hl=it-IT")
      end}].
