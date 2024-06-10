struct Todo {
  string title = "new todo";
  string content = "new todo";
  string date = "now";
  bool completed = false;
  int id = 0;
};

vector<Todo> todos = ([]() {
  vector<Todo> data;

  return data;
})();

int todoIndex = todos.size();

//main page
server.Get("/", make_localhost_handler([&](const Request req, Response &res) {
  @template addForm from ../frontend/comp/add-form.html

  @template ct from ../frontend/index.html

  res.set_content(ct, "text/html");
}));

//add page
server.Get("/add", make_localhost_handler([&](const Request req, Response &res) {
  auto title = req.get_param_value("title");
  auto content = req.get_param_value("content");
  auto date = req.get_param_value("date");

  Todo newTodo;

  newTodo.title = title;
  newTodo.content = content;
  newTodo.date = date;
  newTodo.id = todoIndex++;

  todos.push_back(newTodo);

  string to = "/";

  @template ct from ../frontend/comp/navigate.html
  
  res.set_content(ct, "text/html");

}));