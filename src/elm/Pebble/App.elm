module Pebble.App (start, Config, App) where

import Effects exposing (Effects, Never)
import Task


type alias Card =
  { title : String
  , body : String
  }


type alias Config model action =
  { init : ( model, Effects action )
  , update : action -> model -> ( model, Effects action )
  , view : Signal.Address action -> model -> Card
  , inputs : List (Signal.Signal action)
  }


type alias App model =
  { card : Signal Card
  , model : Signal model
  , tasks : Signal (Task.Task Never ())
  }


start : Config model action -> App model
start config =
  let
    singleton action =
      [ action ]

    messages =
      Signal.mailbox []

    address =
      Signal.forwardTo messages.address singleton

    updateStep action ( oldModel, accumulatedEffects ) =
      let
        ( newModel, additionalEffects ) =
          config.update action oldModel
      in
        ( newModel, Effects.batch [ accumulatedEffects, additionalEffects ] )

    update actions ( model, _ ) =
      List.foldl updateStep ( model, Effects.none ) actions

    inputs =
      Signal.mergeMany (messages.signal :: List.map (Signal.map singleton) config.inputs)

    effectsAndModel =
      Signal.foldp update config.init inputs

    model =
      Signal.map fst effectsAndModel
  in
    { card = Signal.map (config.view address) model
    , model = model
    , tasks = Signal.map (Effects.toTask messages.address << snd) effectsAndModel
    }
