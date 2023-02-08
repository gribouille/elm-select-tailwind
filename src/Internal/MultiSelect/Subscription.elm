module Internal.MultiSelect.Subscription exposing (..)

import Internal.MultiSelect.Config exposing (Config(..))
import Internal.MultiSelect.State exposing (..)
import Internal.Prelude exposing (iff)
import Internal.Subscription exposing (subscription)


subscriptions : Config a msg -> State a -> Sub msg
subscriptions (Config { pipe }) (State s) =
    iff s.isOpened (subscription (pipe <| State { s | isOpened = False })) Sub.none
