@import server/init.w

Server server;

@import server/routes.w

//assets public serverd
serve_public(server, "/assets", "assets");

@import server/error-handeler.w

run(&server, 5678, "/");