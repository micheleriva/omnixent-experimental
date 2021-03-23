-module(cache).

-import(time_utils, [get_timestamp/0]).

-export([compute_key/4,
         delete_expired_records/0,
         insert_service/5,
         lookup_service/4]).

compute_key(Service, Term, Language, Country) ->
    Key = string:join([atom_to_list(Service),
                       Term,
                       atom_to_list(Language),
                       atom_to_list(Country)],
                      ":"),
    list_to_atom(Key).

lookup_service(Service, Term, Language, Country) ->
    Key = compute_key(Service, Term, Language, Country),
    ets:lookup(service_cache, Key).

insert_service(Service, Term, Language, Country,
               Result) ->
    Key = compute_key(Service, Term, Language, Country),
    Timestamp = get_timestamp(),
    ets:insert(service_cache, {Key, Result, Timestamp}).

delete_expired_records() ->
    ets:select_delete(service_cache,
                      [{{'$1', '$2', '$3'},
                        [{'<',
                          '$3',
                          get_timestamp() - 86400000}], % 86400000 = 24 hours
                        [true]}]).
