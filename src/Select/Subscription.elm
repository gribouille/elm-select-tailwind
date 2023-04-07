module Select.Subscription exposing (subscriptions)

import Select.Config exposing (Config(..))
import Select.State exposing (State(..))
import Subscription exposing (subscription)
import Util exposing (iff)


subscriptions : Config a msg -> State a -> Sub msg
subscriptions (Config { pipe }) (State s) =
    iff s.isOpened (subscription (pipe <| State { s | isOpened = False })) Sub.none
