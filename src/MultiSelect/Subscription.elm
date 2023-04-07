module MultiSelect.Subscription exposing (subscriptions)

import MultiSelect.Config exposing (Config(..))
import MultiSelect.State exposing (State(..))
import Subscription exposing (subscription)
import Util exposing (iff)


subscriptions : Config a msg -> State a -> Sub msg
subscriptions (Config { pipe }) (State s) =
    iff s.isOpened (subscription (pipe <| State { s | isOpened = False })) Sub.none
