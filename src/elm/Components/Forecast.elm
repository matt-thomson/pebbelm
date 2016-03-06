module Components.Forecast (init, update, view, Action, Model) where

import Config
import Effects exposing (Effects, Never)
import Http
import Json.Decode exposing ((:=), Decoder)
import Task exposing (Task)


type alias Model =
  Maybe String


type Action
  = Forecast String
  | Error


init : ( Model, Effects Action )
init =
  ( Nothing, Effects.task get )


update : Action -> Model -> Model
update action model =
  let
    forecast =
      case action of
        Forecast forecast ->
          forecast

        Error ->
          "Error"
  in
    Just forecast


view : Model -> String
view model =
  "Forecast: " ++ Maybe.withDefault "Loading..." model


type alias Response =
  { currently : DataPoint
  }


type alias DataPoint =
  { summary : String
  }


get : Task Never Action
get =
  let
    decodeDataPoint =
      Json.Decode.object1 DataPoint ("summary" := Json.Decode.string)

    decodeResponse =
      Json.Decode.object1 Response ("currently" := decodeDataPoint)

    url =
      "https://api.forecast.io/forecast/" ++ Config.forecastIoKey ++ "/51.408837,-0.066440"
  in
    Http.get decodeResponse url
      |> Task.map (\x -> Forecast x.currently.summary)
      |> Task.toMaybe
      |> Task.map (Maybe.withDefault Error)
