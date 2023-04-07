module Select exposing
    ( ID, State, init, get, selected, set, select, selectByID
    , Config, config, withClass, withCheck, withPlaceholder
    , view, subscriptions
    )

{-| Select component.


# State

@docs ID, State, init, get, selected, set, select, selectByID


# Configuration

@docs Config, config, withClass, withCheck, withPlaceholder


# Component

@docs view, subscriptions

-}

import Html exposing (Html)
import Select.Config
import Select.Select
import Select.State
import Select.Subscription


{-| ID of a element.
-}
type alias ID =
    Select.Config.ID


{-| Opaque type for the component's state.
-}
type alias State a =
    Select.State.State a


{-| Opaque type for the component's configuration.
-}
type alias Config a msg =
    Select.Config.Config a msg


{-| Initialize a default and empty state.
-}
init : State a
init =
    Select.State.init


{-| Get the data from the `State`.
-}
get : State a -> List a
get =
    Select.State.get


{-| Get the selected item or Nothing.
-}
selected : State a -> Maybe a
selected =
    Select.State.selected


{-| Set the data in the `State`.
-}
set : State a -> List a -> State a
set =
    Select.State.set


{-| Select or unselect (Nothing) an item.
-}
select : Maybe a -> State a -> State a
select =
    Select.State.select


{-| Select or unselect (Nothing) an item by ID.
-}
selectByID : Maybe ID -> Config a msg -> State a -> State a
selectByID =
    Select.Config.selectByID


{-| Initialize the component's configuration.

    config : Select.Config User Msg
    config =
        Select.config
            (String.fromInt << .id)
            (\x -> x.firstname ++ " " ++ x.lastname)
            OnSelectState
            |> Select.withPlaceholder "Select simple"
            |> Select.withCheck True

-}
config : (a -> ID) -> (a -> String) -> (State a -> msg) -> Config a msg
config =
    Select.Config.config


{-| Highlight if the value is not valid.
-}
withCheck : Bool -> Config a msg -> Config a msg
withCheck =
    Select.Config.withCheck


{-| Customize the search input placeholder.
-}
withPlaceholder : String -> Config a msg -> Config a msg
withPlaceholder =
    Select.Config.withPlaceholder


{-| Add custom class to the component.
-}
withClass : String -> Config a msg -> Config a msg
withClass =
    Select.Config.withClass


{-| Component's subscriptions.
-}
subscriptions : Config a msg -> State a -> Sub msg
subscriptions =
    Select.Subscription.subscriptions


{-| Component's view.
-}
view : Config a msg -> State a -> Html msg
view =
    Select.Select.view
