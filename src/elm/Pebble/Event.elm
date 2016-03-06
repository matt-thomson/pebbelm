module Pebble.Event (..) where

import Pebble.Button as Button


type Event
  = Click Button.Button
  | NoOp


parseEvent : String -> Maybe Event
parseEvent event =
  case event of
    "click.up" ->
      Just (Click Button.Up)

    "click.down" ->
      Just (Click Button.Down)

    "click.select" ->
      Just (Click Button.Select)

    _ ->
      Nothing


events : Signal String -> Signal Event
events =
  Signal.filterMap parseEvent NoOp
