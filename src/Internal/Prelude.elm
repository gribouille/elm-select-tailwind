module Internal.Prelude exposing (..)


iff : Bool -> a -> a -> a
iff cond true false =
    if cond then
        true

    else
        false
