module Components.Counter (init, update, view, Action(..), Model) where

import Pebble.Button exposing (Button)


type alias Model =
  Int


type Action
  = Click Button


init : Model
init =
  0


update : Action -> Model -> Model
update action model =
  case action of
    Click button ->
      case button of
        Pebble.Button.Up ->
          model + 1

        Pebble.Button.Down ->
          model - 1

        Pebble.Button.Select ->
          0


view : Model -> String
view model =
  "Counter: " ++ (toString model)
