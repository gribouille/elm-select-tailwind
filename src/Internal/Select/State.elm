module Internal.Select.State exposing (..)


type State a
    = State
        { selected : Maybe a
        , search : String
        , isOpened : Bool
        , data : List a
        , isValid : Maybe Bool
        }


init : State a
init =
    State
        { selected = Nothing
        , search = ""
        , isOpened = False
        , data = []
        , isValid = Nothing
        }


set : State a -> List a -> State a
set (State s) data =
    State { s | data = data }


get : State a -> List a
get (State s) =
    s.data


select : Maybe a -> State a -> State a
select v (State s) =
    State { s | selected = v }


selected : State a -> Maybe a
selected (State s) =
    s.selected
