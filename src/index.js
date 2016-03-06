var UI = require('ui');
var Elm = require('./elm/Main.elm');

var card = new UI.Card({});
card.show();

var app = Elm.worker(Elm.Main, { clicks: '' });

app.ports.card.subscribe(function(message) {
  card.title(message['title'])
  card.body(message['body']);
});

card.on('click', 'up', function() {
  app.ports.clicks.send('up');
});

card.on('click', 'down', function() {
  app.ports.clicks.send('down');
});

card.on('click', 'select', function() {
  app.ports.clicks.send('select');
});
