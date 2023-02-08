module Select_1 exposing (..)

import Browser
import Data exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Select


type alias SelectState =
    Select.State User


type alias Model =
    SelectState


type Msg
    = OnSelectState SelectState


config : Select.Config User Msg
config =
    Select.config
        (String.fromInt << .id)
        (\x -> x.firstname ++ " " ++ x.lastname)
        OnSelectState
        |> Select.withPlaceholder "Select simple"
        |> Select.withCheck True


init : () -> ( Model, Cmd Msg )
init _ =
    ( Select.set Select.init data, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "bg-slate-100" ]
        [ div [ class "p-8 bg-white border border-gray-500 m-4" ]
            [ h1 [ class "text-xl font-bold mb-4" ] [ text "Example Select 1" ]
            , Select.view config model
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
        , subscriptions = Select.subscriptions config
        }
