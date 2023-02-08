module MultiSelect exposing
    ( ID, State, init, get, set
    , Config, config, withClass, withPlaceholder
    , view, subscriptions
    )

{-| MultiSelect component.


# State

@docs ID, State, init, get, set


# Config

@docs Config, config, withClass, withPlaceholder


# Component

@docs view, subscriptions

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Internal.MultiSelect.Config exposing (..)
import Internal.MultiSelect.MultiSelect
import Internal.MultiSelect.State exposing (..)
import Internal.MultiSelect.Subscription


{-| ID of a element.
-}
type alias ID =
    Internal.MultiSelect.Config.ID


{-| Opaque type for the component's state.
-}
type alias State a =
    Internal.MultiSelect.State.State a


{-| Opaque type for the component's configuration.
-}
type alias Config a msg =
    Internal.MultiSelect.Config.Config a msg


{-| Initialize a default and empty state.
-}
init : State a
init =
    Internal.MultiSelect.State.init


{-| Set the data in the `State`.
-}
set : State a -> List a -> State a
set =
    Internal.MultiSelect.State.set


{-| Get the data from the `State`.
-}
get : State a -> List a
get =
    Internal.MultiSelect.State.get


{-| Initialize the component's configuration.

    config : MultiSelect.Config User Msg
    config =
        MultiSelect.config
            (String.fromInt << .id)
            (\x -> x.firstname ++ " " ++ x.lastname)
            OnSelectState

-}
config : (a -> ID) -> (a -> String) -> (State a -> msg) -> Config a msg
config =
    Internal.MultiSelect.Config.config


{-| Customize the search input placeholder.
-}
withPlaceholder : String -> Config a msg -> Config a msg
withPlaceholder =
    Internal.MultiSelect.Config.withPlaceholder


{-| Add custom class to the component.
-}
withClass : String -> Config a msg -> Config a msg
withClass =
    Internal.MultiSelect.Config.withClass


{-| Component's subscriptions.
-}
subscriptions : Config a msg -> State a -> Sub msg
subscriptions =
    Internal.MultiSelect.Subscription.subscriptions


{-| Component's view.
-}
view : Config a msg -> State a -> Html msg
view =
    Internal.MultiSelect.MultiSelect.view
