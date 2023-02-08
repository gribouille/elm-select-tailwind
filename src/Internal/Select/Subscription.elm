module Internal.Select.Subscription exposing (..)

import Internal.Prelude exposing (iff)
import Internal.Select.Config exposing (Config(..))
import Internal.Select.State exposing (..)
import Internal.Subscription exposing (subscription)


subscriptions : Config a msg -> State a -> Sub msg
subscriptions (Config { pipe }) (State s) =
    iff s.isOpened (subscription (pipe <| State { s | isOpened = False })) Sub.none
