-module(service_commons).

-export([new/2, new/4]).

-record(serviceRequest,
        {service :: string(),
         term :: string(),
         country :: atom(),
         language :: atom()}).

new(Service, Term) ->
    #serviceRequest{service = Service, term = Term,
                    country = us, language = en}.

new(Service, Term, Country, Language) ->
    #serviceRequest{service = Service, term = Term,
                    country = Country, language = Language}.
