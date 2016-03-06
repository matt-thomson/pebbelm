module Main (..) where

import Effects exposing (Effects)
import Pebble.App exposing (start, App, Card)
import Pebble.Button exposing (Button)
import Pebble.Event exposing (Event)
import Signal exposing (Address)


type alias Model =
  { counter : Int
  }


init : ( Model, Effects Action )
init =
  let
    model =
      { counter = 0 }
  in
    ( model, Effects.none )


type Action
  = PebbleEvent Event


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    PebbleEvent (Pebble.Event.Click button) ->
      case button of
        Pebble.Button.Up ->
          ( { model | counter = model.counter + 1 }, Effects.none )

        Pebble.Button.Down ->
          ( { model | counter = model.counter - 1 }, Effects.none )

        Pebble.Button.Select ->
          ( { model | counter = 0 }, Effects.none )

    PebbleEvent (Pebble.Event.NoOp) ->
      ( model, Effects.none )


view : Address Action -> Model -> Card
view address model =
  { title = "Pebbelm"
  , body = "Counter: " ++ (toString model.counter)
  }


app : App Model
app =
  start
    { init = init
    , view = view
    , update = update
    , inputs = []
    , events = events
    , handler = PebbleEvent
    }


port card : Signal Card
port card =
  app.card


port events : Signal String
