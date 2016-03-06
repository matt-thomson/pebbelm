# Pebbelm

Proof-of-concept [Elm](http://elm-lang.org/) app for [Pebble](https://www.pebble.com/) smartwatches.  Displays the current weather in London, together with a counter that can be controlled via the up/down/select buttons.

[![wercker status](https://app.wercker.com/status/92264874d0204e273a47e4980e346cd8/s/master "wercker status")](https://app.wercker.com/project/bykey/92264874d0204e273a47e4980e346cd8)

![Screenshot](pebbelm.png?raw=true)

## Building the app

First, sign up for an API key for [forecast.io](https://forecast.io/).  Copy `src/elm/Config.elm.example` to `src/elm/Config.elm`, and fill in the key in that file.

Then:

```
npm install
npm run build
```

This will generate `dist/app.js`, which can be built into a [Pebble.js](https://pebble.github.io/pebblejs/) app using [CloudPebble](https://cloudpebble.net/).
