Server server;

server.Get("/", [&](const Request &, Response &res) {
  res.set_content("Hello World!", "text/plain");
});

@import error-handeler.w

run(&server, 5678, "/");