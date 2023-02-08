module Data exposing (..)

type alias User =
    { id : Int
    , firstname : String
    , lastname : String
    }


data : List User
data =
    [ User 1 "John" "Doe"
    , User 2 "Cleo" "Gregg"
    , User 3 "Dennis" "Johnson"
    , User 4 "Julie" "Thorne"
    , User 5 "Dennis" "Johnson"
    , User 6 "Julie 1" "Thorne"
    , User 7 "Dennis 2" "Johnson"
    , User 8 "Julie 3" "Thorne"
    , User 9 "Dennis 4" "Johnson"
    , User 10 "Julie 5" "Thorne"
    ]


langs : List String
langs =
    [ "Agda"
    ,"Clean"
    ,"Coq (Gallina)"
    ,"Cuneiform"
    ,"Curry"
    ,"Elm"
    ,"Futhark"
    ,"Haskell"
    ,"Hope"
    ,"Idris"
    ,"Joy"
    ,"Lean"
    ,"Mercury"
    ,"Miranda"
    ,"PureScript"
    ,"Ur"
    ,"KRC"
    ,"SAC"
    ,"SASL"
    ,"SequenceL"
    ]
