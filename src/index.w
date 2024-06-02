Server server;

int trafficCount = 0;

//main page
server.Get("/", [&](const Request req, Response &res) {
  @template ct from frontend/index.html
  
  trafficCount++;

  res.set_content(ct, "text/html");
});

//css style
server.Get("/style", [&](const Request req, Response &res) {
  @template ct from frontend/index.css

  res.set_content(ct, "text/css");
});

//assets public serverd
server.set_mount_point("/assets", "./assets");

@import server/error-handeler.w

run(&server, 5678, "/");