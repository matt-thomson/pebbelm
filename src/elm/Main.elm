module Main (..) where

import Components.Counter as Counter
import Effects exposing (Effects)
import Pebble.App exposing (start, App, Card)
import Pebble.Event exposing (Event)
import Signal exposing (Address)


type alias Model =
  { counter : Counter.Model
  }


type Action
  = PebbleEvent Event


init : ( Model, Effects Action )
init =
  ( { counter = Counter.init }, Effects.none )


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    PebbleEvent (Pebble.Event.Click button) ->
      let
        counter =
          Counter.update (Counter.Click button) model.counter
      in
        ( { model | counter = counter }, Effects.none )

    PebbleEvent (Pebble.Event.NoOp) ->
      ( model, Effects.none )


view : Address Action -> Model -> Card
view address model =
  { title = "Pebbelm"
  , body = Counter.view model.counter
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
