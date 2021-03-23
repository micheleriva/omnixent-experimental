-module(call_service).

-export([make_request/5, request/4]).

-define(Method, get).

-define(Headers, []).

-define(Payload, <<>>).

-define(Options, []).

get_lang(de) -> lang_de:terms();
get_lang(en) -> lang_en:terms();
get_lang(fr) -> lang_fr:terms();
get_lang(it) -> lang_it:terms();
get_lang(pt) -> lang_pt:terms();
get_lang(Language) ->
    throw(Language ++ " language is not available").

get_url(google, Term, Country, Language) ->
    google:format_uri(Term, Country, Language);
get_url(youtube, Term, Country, Language) ->
    youtube:format_uri(Term, Country, Language).

extract_body(google, Body) ->
    google:collect_values(google:extract_body(Body));
extract_body(youtube, Body) ->
    youtube:collect_values(youtube:extract_body(Body)).

make_request(Service, Term, Country, Language,
             LangTerm) ->
    T = string:join(string:replace(LangTerm, "@", Term),
                    ""),
    URL = get_url(Service, T, Country, Language),
    {ok, _, _, ClientRef} = hackney:request(?Method,
                                            URL,
                                            ?Headers,
                                            ?Payload,
                                            ?Options),
    {ok, Body} = hackney:body(ClientRef),
    extract_body(Service, Body).

request(Service, Term, Country, Language) ->
    Terms = get_lang(Language),
    pmap:pmap(fun (LangTerm) ->
                      {Term,
                       LangTerm,
                       make_request(Service,
                                    Term,
                                    Country,
                                    Language,
                                    LangTerm)}
              end,
              Terms).
