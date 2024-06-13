auto getTodosHtml = [&]() {
  string todosHtml = "";
  for (const auto &todo : todos) {
    @template toDoHtml from ../../frontend/comp/todo.html
    todosHtml += toDoHtml;
  }
  return todosHtml;
};

// Main page
server.Get("/", make_localhost_handler([&](const Request &req, Response &res) {
  @template addForm from ../../frontend/comp/add-form.html
  @template ct from ../../frontend/index.html

  res.set_content(ct, "text/html");
}));