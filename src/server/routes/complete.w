// Toggle complete status
server.Post("/complete", make_localhost_handler([&](const Request &req, Response &res) {
  auto id_str = req.get_param_value("id");
  int id = -1;

  try {
    id = std::stoi(id_str);
  } catch (const std::invalid_argument& e) {
    res.status = 400;
    return;
  }

  for (auto &todo : todos) {
    if (todo.id == id) {
      todo.completed = !todo.completed;
      break;
    }
  }

  string to = "/";
  @template ct from ../../frontend/comp/navigate.html

  res.set_content(ct, "text/html");
  
  saveTodos();
}));