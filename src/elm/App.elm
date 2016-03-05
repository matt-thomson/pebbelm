module App where

type alias Card =
  { title : String
  , body : String
  }


type alias Model =
  { counter: Int
  }


init : Model
init =
  { counter = 0
  }


type Button =
  Up
  | Down
  | Select


type Action =
  NoOp
  | Click Button


update : Action -> Model -> Model
update action model =
  case action of
    Click Up ->
      { model | counter = model.counter + 1 }
    Click Down ->
      { model | counter = model.counter - 1 }
    Click Select ->
      { model | counter = 0 }
    NoOp ->
      model


view : Model -> Card
view model =
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


model : Signal Model
model =
  Signal.foldp update init actions


port card : Signal Card
port card =
  Signal.map view model
