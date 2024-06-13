// Delete todo
server.Post("/delete", make_localhost_handler([&](const Request &req, Response &res) {
  auto id_str = req.get_param_value("id");
  int id;

  try {
    id = std::stoi(id_str);
  } catch (const std::invalid_argument& e) {
    res.status = 400;
    return;
  }

  auto it = std::remove_if(todos.begin(), todos.end(), [id](const Todo& todo) {
    return todo.id == id;
  });

  if (it != todos.end()) {
    todos.erase(it, todos.end());
  }

  string to = "/";
  @template ct from ../../frontend/comp/navigate.html

  res.set_content(ct, "text/html");
}));