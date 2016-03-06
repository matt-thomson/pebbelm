module Main (..) where

import Effects exposing (Effects)
import Pebble.App exposing (start, App)
import Signal exposing (Address)


type alias Card =
  { title : String
  , body : String
  }


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


type Button
  = Up
  | Down
  | Select


type Action
  = NoOp
  | Click Button


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    Click Up ->
      ( { model | counter = model.counter + 1 }, Effects.none )

    Click Down ->
      ( { model | counter = model.counter - 1 }, Effects.none )

    Click Select ->
      ( { model | counter = 0 }, Effects.none )

    NoOp ->
      ( model, Effects.none )


view : Address Action -> Model -> Card
view address model =
  { title = "Pebbelm"
  , body = "Counter: " ++ (toString model.counter)
  }


port clicks : Signal (Maybe String)
parseButton : String -> Maybe Button
parseButton click =
  case click of
    "up" ->
      Just Up

    "down" ->
      Just Down

    "select" ->
      Just Select

    _ ->
      Nothing


actions : Signal Action
actions =
  clicks
    |> Signal.map (\x -> Maybe.andThen x parseButton)
    |> Signal.map (Maybe.map Click)
    |> Signal.filterMap identity NoOp


app : App Model
app =
  start { init = init, view = view, update = update, inputs = [] }


port card : Signal Card
port card =
  app.card
