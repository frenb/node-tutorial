var express = require('express');
var app = express();

/*--- SECTION BELOW IS FOR HEROKU DEPLOYMENT---
*
*  Heroku sets the environment variable PORT in the dyno
*  your docker image is running on.
*
*  You need to run your service on PORT to forward requests
*  externally over port 80. Services cannot be directly exposed
*  over other ports on Heroku.
*/

// sets variable PORT to environment variable PORT
var PORT = process.env.PORT;

if(PORT === undefined)
{
  // checks to see if PORT was defined, and if not sets PORT to 3000
  PORT=3000;
}

app.get('/', function (req, res) {
  res.send('Hello great, grand world of Gigster!!')
})

var server = app.listen(PORT, function () {
  var port = server.address().port;
  console.log('Example app listening on port %s!', port)
})

module.exports = server;
