module MultiSelect exposing
    ( ID, State, init, get, selected, set, select, selectByID
    , Config, config, withClass, withPlaceholder
    , view, subscriptions
    )

{-| MultiSelect component.


# State

@docs ID, State, init, get, selected, set, select, selectByID


# Configuration

@docs Config, config, withClass, withPlaceholder


# Component

@docs view, subscriptions

-}

import Html exposing (Html)
import MultiSelect.Config
import MultiSelect.MultiSelect
import MultiSelect.State
import MultiSelect.Subscription


{-| ID of a element.
-}
type alias ID =
    MultiSelect.Config.ID


{-| Opaque type for the component's state.
-}
type alias State a =
    MultiSelect.State.State a


{-| Opaque type for the component's configuration.
-}
type alias Config a msg =
    MultiSelect.Config.Config a msg


{-| Initialize a default and empty state.
-}
init : State a
init =
    MultiSelect.State.init


{-| Set the data in the `State`.
-}
set : State a -> List a -> State a
set =
    MultiSelect.State.set


{-| Set the selected items.
-}
select : List a -> State a -> State a
select =
    MultiSelect.State.select


{-| Select or unselect items by ID.
-}
selectByID : List ID -> Config a msg -> State a -> State a
selectByID =
    MultiSelect.Config.selectByID


{-| Get the data from the `State`.
-}
get : State a -> List a
get =
    MultiSelect.State.get


{-| Get the selected items from the `State`.
-}
selected : State a -> List a
selected =
    MultiSelect.State.selected


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
    MultiSelect.Config.config


{-| Customize the search input placeholder.
-}
withPlaceholder : String -> Config a msg -> Config a msg
withPlaceholder =
    MultiSelect.Config.withPlaceholder


{-| Add custom class to the component.
-}
withClass : String -> Config a msg -> Config a msg
withClass =
    MultiSelect.Config.withClass


{-| Component's subscriptions.
-}
subscriptions : Config a msg -> State a -> Sub msg
subscriptions =
    MultiSelect.Subscription.subscriptions


{-| Component's view.
-}
view : Config a msg -> State a -> Html msg
view =
    MultiSelect.MultiSelect.view
