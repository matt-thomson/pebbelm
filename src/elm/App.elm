module App where

type alias Card =
  { title : String
  , body : String
  }


type alias Model = Int


init : Model
init = 0


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
      model + 1
    Click Down ->
      model - 1
    Click Select ->
      0
    NoOp ->
      model


view : Model -> Card
view model =
  { title = "Counter"
  , body = toString model
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
