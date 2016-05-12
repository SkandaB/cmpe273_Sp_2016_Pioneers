var http = require('http');

var arg = process.argv.slice(2);


var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Hello this is a Demo app  for team pioneers ");
}).listen(parseInt(arg));

  console.log('Server started');
console.log('running at port ' + arg);
