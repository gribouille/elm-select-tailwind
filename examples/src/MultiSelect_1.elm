module MultiSelect_1 exposing (main)

import Browser
import Data exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import MultiSelect


type alias SelectState =
    MultiSelect.State User


type alias Model =
    SelectState


type Msg
    = OnSelectState SelectState


config : MultiSelect.Config User Msg
config =
    MultiSelect.config
        (String.fromInt << .id)
        (\x -> x.firstname ++ " " ++ x.lastname)
        OnSelectState


init : () -> ( Model, Cmd Msg )
init _ =
    ( MultiSelect.set MultiSelect.init data, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "bg-slate-100" ]
        [ div [ class "p-8 bg-white border border-gray-500 m-4" ]
            [ h1 [ class "text-xl font-bold mb-4" ] [ text "Example MultiSelect 1" ]
            , MultiSelect.view config model
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        OnSelectState s ->
            ( s, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = MultiSelect.subscriptions config
        }
