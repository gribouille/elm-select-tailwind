module Internal.MultiSelect.Config exposing (..)

import Internal.MultiSelect.State exposing (State)


type alias ID =
    String


type alias GetID a =
    a -> ID


type alias GetValue a =
    a -> String


type Config a msg
    = Config
        { placeholder : String
        , getID : a -> ID
        , getValue : a -> String
        , pipe : State a -> msg
        , class : String
        }


config : (a -> ID) -> (a -> String) -> (State a -> msg) -> Config a msg
config getID getValue pipe =
    Config
        { placeholder = "..."
        , getID = getID
        , getValue = getValue
        , pipe = pipe
        , class = ""
        }


withPlaceholder : String -> Config a msg -> Config a msg
withPlaceholder v (Config c) =
    Config { c | placeholder = v }


withClass : String -> Config a msg -> Config a msg
withClass v (Config c) =
    Config { c | class = v }
