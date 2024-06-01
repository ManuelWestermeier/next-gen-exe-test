Server server;

int trafficCount = 0;

//main page
server.Get("/", [&](const Request req, Response &res) {
  @template ct from index.html
  
  res.set_content(ct, "text/html");

  trafficCount++;
});

//assets public serverd
server.set_mount_point("/assets", "./assets");

@import error-handeler.w

run(&server, 5678, "/");