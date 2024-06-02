Server server;

int trafficCount = 0;

//main page
server.Get("/", make_localhost_handler([&](const Request req, Response &res) {
  @template ct from frontend/index.html
  
  trafficCount++;

  res.set_content(ct, "text/html");
}));

//secound page
server.Get("/page/:id", make_localhost_handler([&](const Request& req, Response& res) {
    int pageId = stoi(req.path_params.at("id"));
    @template page from frontend/page.html
    res.set_content(page, "text/html");
}));

//css style
server.Get("/style", make_localhost_handler([&](const Request req, Response &res) {
  @template ct from frontend/index.css

  res.set_content(ct, "text/css");
}));

server.Get("/close", [&](Request req, Response res) {
  res.set_content("closed", "text/plain");
  server.stop();
});

//assets public serverd
serve_public(server, "/assets", "./assets");

@import server/error-handeler.w

run(&server, 5678, "/");