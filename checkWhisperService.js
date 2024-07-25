const http = require('http');

const options = {
  hostname: 'localhost',  // Change this to your server's hostname or IP address
  port: 9090,             // The port your Whisper service is running on
  path: '/',              // The path to check, adjust if your service has a specific health check endpoint
  method: 'GET',
};

function checkService() {
  const req = http.request(options, (res) => {
    let data = '';

    res.on('data', (chunk) => {
      data += chunk;
    });

    res.on('end', () => {
      console.log(`STATUS: ${res.statusCode}`);
      console.log('Service is running fine.');
    });
  });

  req.on('error', (e) => {
    console.error(`Service check failed: ${e.message}`);
  });

  req.end();
}

setInterval(checkService, 5000); // Check every 5 seconds
