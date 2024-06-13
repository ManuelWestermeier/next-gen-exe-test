// Add page
server.Get("/add", make_localhost_handler([&](const Request &req, Response &res) {
  auto title = req.get_param_value("title");
  auto content = req.get_param_value("content");

  Todo newTodo;
  newTodo.title = title;
  newTodo.content = content;

  todos.push_back(newTodo);

  string to = "/";
  @template ct from ../../frontend/comp/navigate.html

  res.set_content(ct, "text/html");
}));