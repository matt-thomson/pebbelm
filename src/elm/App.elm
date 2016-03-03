module App where

type alias Card =
  { title : String
  , body : String
  }


type alias Model = Int


init : Model
init = 0


type Action = NoOp | Increment | Decrement


update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      model + 1
    Decrement ->
      model - 1
    NoOp ->
      model


view : Model -> Card
view model =
  { title = "Counter"
  , body = toString model
  }


port clicks : Signal String


parseClick : String -> Action
parseClick click =
  case click of
    "up" ->
      Increment
    "down" ->
      Decrement
    _ ->
      NoOp


actions : Signal Action
actions =
  Signal.map parseClick clicks


model : Signal Model
model =
  Signal.foldp update init actions


port card : Signal Card
port card =
  Signal.map view model
