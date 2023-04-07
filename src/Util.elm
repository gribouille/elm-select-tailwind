module Util exposing (find, iff)


iff : Bool -> a -> a -> a
iff cond true false =
    if cond then
        true

    else
        false


find : (a -> Bool) -> List a -> Maybe a
find predicate list =
    case list of
        [] ->
            Nothing

        first :: rest ->
            if predicate first then
                Just first

            else
                find predicate rest
