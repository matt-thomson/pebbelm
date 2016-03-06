module Main (..) where

import Components.Counter as Counter
import Components.Forecast as Forecast
import Effects exposing (Effects, Never)
import Pebble.App exposing (start, App, Card)
import Pebble.Event exposing (Event)
import Signal exposing (Address)
import Task exposing (Task)


type alias Model =
  { counter : Counter.Model
  , forecast : Forecast.Model
  }


type Action
  = PebbleEvent Event
  | ForecastAction Forecast.Action


init : ( Model, Effects Action )
init =
  let
    counter =
      Counter.init

    ( forecast, forecastFx ) =
      Forecast.init

    fx =
      Effects.map ForecastAction forecastFx
  in
    ( { counter = counter, forecast = forecast }, fx )


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

    ForecastAction action ->
      let
        forecast =
          Forecast.update action model.forecast
      in
        ( { model | forecast = forecast }, Effects.none )


view : Address Action -> Model -> Card
view address model =
  let
    body =
      Counter.view model.counter ++ "\n" ++ Forecast.view model.forecast
  in
    { title = "Pebbelm"
    , body = body
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


port tasks : Signal (Task Never ())
port tasks =
  app.tasks


port events : Signal String
