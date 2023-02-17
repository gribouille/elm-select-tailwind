module Internal.Select.Config exposing (..)

import Internal.Prelude exposing (find)
import Internal.Select.State exposing (State(..))


type alias ID =
    String


type alias GetID a =
    a -> ID


type alias GetValue a =
    a -> String


type Config a msg
    = Config
        { placeholder : String
        , checkValue : Bool
        , getID : a -> ID
        , getValue : a -> String
        , pipe : State a -> msg
        , class : String
        }


config : (a -> ID) -> (a -> String) -> (State a -> msg) -> Config a msg
config getID getValue pipe =
    Config
        { placeholder = ""
        , getID = getID
        , getValue = getValue
        , pipe = pipe
        , checkValue = False
        , class = ""
        }


selectByID : Maybe ID -> Config a msg -> State a -> State a
selectByID mv (Config c) (State s) =
    State { s | selected = mv |> Maybe.andThen (\v -> find (\x -> c.getID x == v) s.data) }


withCheck : Bool -> Config a msg -> Config a msg
withCheck v (Config c) =
    Config { c | checkValue = v }


withPlaceholder : String -> Config a msg -> Config a msg
withPlaceholder v (Config c) =
    Config { c | placeholder = v }


withClass : String -> Config a msg -> Config a msg
withClass v (Config c) =
    Config { c | class = v }
