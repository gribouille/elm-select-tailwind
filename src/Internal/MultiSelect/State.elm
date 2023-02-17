module Internal.MultiSelect.State exposing (..)


type State a
    = State
        { selected : List a
        , search : String
        , isOpened : Bool
        , data : List a
        }


init : State a
init =
    State
        { selected = []
        , search = ""
        , isOpened = False
        , data = []
        }


set : State a -> List a -> State a
set (State s) data =
    State { s | data = data }


get : State a -> List a
get (State s) =
    s.data


select : List a -> State a -> State a
select v (State s) =
    State { s | selected = v }


selected : State a -> List a
selected (State s) =
    s.selected
