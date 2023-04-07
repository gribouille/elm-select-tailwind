module MultiSelect.MultiSelect exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import MultiSelect.Config exposing (..)
import MultiSelect.State exposing (..)
import Svg as S
import Svg.Attributes as SA
import Util exposing (..)


view : Config a msg -> State a -> Html msg
view (Config c) (State s) =
    div [ class <| "w-full flex flex-col items-center mx-auto " ++ c.class ]
        [ div [ class "w-full mx-auto" ]
            [ div [ class "flex flex-col items-center relative" ]
                [ div [ class "w-full" ]
                    [ div [ class "flex border border-gray-200 bg-white rounded" ]
                        [ viewSelectedItems (Config c) (State s)
                        , viewInputSearch (Config c) (State s)
                        , viewButtonShow (Config c) (State s)
                        ]
                    ]
                , div
                    [ class <| """absolute shadow top-[100%] bg-white z-40
                                    w-full lef-0 rounded max-h-[300px]
                                    overflow-y-auto mt-2""" ++ iff s.isOpened "" " hidden"
                    ]
                    [ viewItems (Config c) (State s)
                    ]
                ]
            ]
        ]


viewInputSearch : Config a msg -> State a -> Html msg
viewInputSearch (Config c) (State s) =
    div [ class "mx-4 grow" ]
        [ input
            [ type_ "text"
            , class "w-full border-0 rounded-md focus:border-blue-400 focus:ring focus:ring-blue-200/50"
            , placeholder c.placeholder
            , value s.search
            , onInput (\x -> c.pipe <| State { s | search = x })
            , onFocus (c.pipe (State { s | isOpened = not s.isOpened }))
            , onFocusIn (c.pipe (State { s | isOpened = True }))
            ]
            []
        ]


onFocusIn : msg -> Attribute msg
onFocusIn msg =
    on "focusin" (Decode.succeed msg)


viewButtonShow : Config a msg -> State a -> Html msg
viewButtonShow (Config c) (State s) =
    div [ class "text-gray-300 w-8 py-1 pl-2 pr-1 border-l flex items-center border-gray-200" ]
        [ button
            [ class "cursor-pointer w-6 h-6 text-gray-600 outline-none focus:outline-none"
            , id "select_dropdown"
            , onClick (c.pipe (State { s | isOpened = not s.isOpened }))
            ]
            [ iff s.isOpened iconDown iconUp
            ]
        ]


viewSelectedItems : Config a msg -> State a -> Html msg
viewSelectedItems (Config c) (State s) =
    div [ class "shrink flex flex-wrap" ] <|
        List.map
            (viewSelectedItem c.getValue
                (\x -> c.pipe <| State { s | selected = removeItem c s x })
            )
            s.selected


viewSelectedItem : (a -> String) -> (a -> msg) -> a -> Html msg
viewSelectedItem getValue click x =
    div
        [ class """flex justify-center items-center m-1 font-medium py-1 px-2
                   bg-white rounded-full text-blue-700 bg-blue-100 border border-blue-300
                """
        ]
        [ div [ class "text-xs font-normal leading-none max-w-full flex-initial" ]
            [ text (getValue x) ]
        , div
            [ class "text-xs font-normal leading-none max-w-full flex-initial"
            , onClick (click x)
            ]
            [ iconDelete ]
        ]


viewItems : Config a msg -> State a -> Html msg
viewItems (Config c) (State s) =
    div [ class "flex flex-col w-full" ] <|
        List.map
            (\x ->
                let
                    isSelected =
                        List.member x s.selected

                    click =
                        \z ->
                            c.pipe
                                (State
                                    { s
                                        | selected =
                                            if isSelected then
                                                removeItem c s z

                                            else
                                                List.append s.selected [ z ]
                                    }
                                )
                in
                viewItem c.getValue click x isSelected
            )
            (filter c s)


viewItem : (a -> String) -> (a -> msg) -> a -> Bool -> Html msg
viewItem getValue click x enable =
    div
        [ class "cursor-pointer w-full border-gray-100 rounded-t border-b hover:bg-blue-100"
        , id "select_dropdown"
        , onClick (click x)
        ]
        [ div
            [ class <|
                "flex w-full items-center p-2 pl-2 border-l-2 relative"
                    ++ iff enable " border-blue-600" " border-transparent hover:border-blue-100"
            ]
            [ div [ class "w-full items-center flex" ]
                [ div [ class "mx-2 leading-6" ]
                    [ text (getValue x) ]
                ]
            ]
        ]


removeItem c s x =
    List.filter (\y -> c.getID y /= c.getID x) s.selected


filter c s =
    s.data
        |> List.filter
            (\x ->
                String.contains (String.toLower s.search)
                    (String.toLower (c.getValue x))
            )


iconUp : S.Svg msg
iconUp =
    S.svg
        [ SA.width "100%"
        , SA.height "100%"
        , SA.fill "none"
        , SA.viewBox "0 0 24 24"
        , SA.stroke "currentColor"
        , SA.strokeWidth "2"
        , SA.strokeLinecap "round"
        , SA.strokeLinejoin "round"
        , SA.class "w-4 h-4"
        ]
        [ S.polygon [ SA.points "18 15 12 9 6 15" ] [] ]


iconDown : S.Svg msg
iconDown =
    S.svg
        [ SA.width "100%"
        , SA.height "100%"
        , SA.fill "none"
        , SA.viewBox "0 0 24 24"
        , SA.stroke "currentColor"
        , SA.strokeWidth "2"
        , SA.strokeLinecap "round"
        , SA.strokeLinejoin "round"
        , SA.class "w-4 h-4"
        ]
        [ S.polygon [ SA.points "6 9 18 9 12 15" ] [] ]


iconDelete : S.Svg msg
iconDelete =
    S.svg
        [ SA.class "cursor-pointer hover:text-blue-400 rounded-full w-4 h-4 ml-2"
        , SA.width "100%"
        , SA.height "100%"
        , SA.fill "none"
        , SA.viewBox "0 0 24 24"
        , SA.stroke "currentColor"
        , SA.strokeWidth "2"
        , SA.strokeLinecap "round"
        , SA.strokeLinejoin "round"
        ]
        [ S.line [ SA.x1 "18", SA.y1 "6", SA.x2 "6", SA.y2 "18" ] []
        , S.line [ SA.x1 "6", SA.y1 "6", SA.x2 "18", SA.y2 "18" ] []
        ]
