module Select.Select exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Select.Config exposing (..)
import Select.State exposing (..)
import Util exposing (..)


view : Config a msg -> State a -> Html msg
view (Config c) (State s) =
    div [ class "relative inline-block w-full mx-auto" ]
        [ div [ class "mx-auto" ]
            [ input
                [ type_ "text"
                , class """block w-full rounded border-gray-300 shadow-sm
                           focus:border-blue-400 focus:ring focus:ring-blue-200/50
                           disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-500
                        """
                , placeholder c.placeholder
                , value
                    (s.selected
                        |> Maybe.map c.getValue
                        |> Maybe.withDefault s.search
                    )
                , onInput (\x -> c.pipe (State { s | search = x, selected = Nothing }))
                , onFocus (c.pipe (State { s | isOpened = not s.isOpened }))
                ]
                []
            ]
        , div
            [ class <|
                """absolute left-0 z-10 mt-2 w-full rounded-lg border border-gray-100
                         bg-white text-left text-sm shadow-lg overflow-y-auto max-h-48"""
                    ++ iff s.isOpened "" " hidden"
            ]
            [ div [ class "p-1" ] <|
                List.map
                    (viewItem c.getValue
                        (\x -> c.pipe (State { s | selected = Just x, isOpened = False }))
                    )
                    (filter c s)
            ]
        ]


viewItem : (a -> String) -> (a -> msg) -> a -> Html msg
viewItem getValue click x =
    a
        [ onClick (click x)
        , id "select_dropdown"
        , class "flex w-full items-center rounded-md px-3 py-2 text-gray-700 hover:bg-gray-100 hover:cursor-pointer"
        ]
        [ text (getValue x) ]


filter c s =
    s.data
        |> List.filter
            (\x ->
                String.contains (String.toLower s.search)
                    (String.toLower (c.getValue x))
            )
