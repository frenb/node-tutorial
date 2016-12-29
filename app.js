var express = require('express')
var app = express()

app.get('/', function (req, res) {
  res.send('Hello Gigster! great to meet you')
})

var server = app.listen(3000, function () {
  var port = server.address().port;
  console.log('Example app listening on port %s!', port)
})

module.exports = server;
