module MultiSelect.Config exposing (Config(..), ID, config, selectByID, withClass, withPlaceholder)

import MultiSelect.State exposing (State(..))


type alias ID =
    String


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


selectByID : List ID -> Config a msg -> State a -> State a
selectByID v (Config c) (State s) =
    State { s | selected = List.filter (\x -> List.member (c.getID x) v) s.data }


withPlaceholder : String -> Config a msg -> Config a msg
withPlaceholder v (Config c) =
    Config { c | placeholder = v }


withClass : String -> Config a msg -> Config a msg
withClass v (Config c) =
    Config { c | class = v }
