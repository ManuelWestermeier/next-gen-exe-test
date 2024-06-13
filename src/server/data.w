struct Todo {
    std::string title = "new todo";
    std::string content = "new todo";

    // Get the date
    std::string date = ([]() {
        time_t t = time(nullptr);
        tm localTime = *localtime(&t);

        std::ostringstream oss;
        oss << std::put_time(&localTime, "%d %h %Y|%H:%M");

        return oss.str();
    })();

    bool completed = false;
    
    // Get The Date
    int id = ([]() {
        return static_cast<int>(std::chrono::system_clock::to_time_t(
            std::chrono::system_clock::now()
        ));
    })();
};

vector<Todo> todos = ([]() {
  vector<Todo> data;
  return data;
})();