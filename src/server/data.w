struct Todo {
    string title = "new todo";
    string content = "new todo";

    // Get the date
    string date = ([]() {
        time_t t = time(nullptr);
        tm localTime = *localtime(&t);

        ostringstream oss;
        oss << put_time(&localTime, "%d %h %Y|%H:%M");

        return oss.str();
    })();

    bool completed = false;
    
    // Get The Date
    int id = ([]() {
        return static_cast<int>(chrono::system_clock::to_time_t(
            chrono::system_clock::now()
        ));
    })();
};

string fileName = ".tododata";

auto replaceAll = [](string str, const string from, const string to) {
    if (from.empty())
        return str;
 
    size_t startPos = 0;
    
    while ((startPos = str.find(from, startPos)) != string::npos) {
        str.replace(startPos, from.length(), to);
        startPos += to.length();
    }

    return str;
};

vector<Todo> todos = ([&]() {
    vector<Todo> todos;
    ifstream file(fileName);

    if (!file.is_open()) {
        cerr << "Error opening file: " << fileName << endl;
        return todos;
    }

    string line;
    Todo todo;

    while (getline(file, line)) {
        todo.title = line;

        if (getline(file, line)) {
            todo.content = line;
        } else {
            break;
        }

        if (getline(file, line)) {
            todo.date = line;
        } else {
            break;
        }

        if (getline(file, line)) {
            todo.completed = (line == "1");
        } else {
            break;
        }

        if (getline(file, line)) {
            todo.id = stoi(line);
        } else {
            break;
        }

        todos.push_back(todo);
    }

    file.close();

    return todos;
})();

auto saveTodos = [&]() {
    
    ofstream file(fileName);
    
    if (!file.is_open()) {
        cerr << "Error opening file: " << endl;
        return;
    }

    for (const auto& todo : todos) {
        // Write each Todo item's details to the file
        file << replaceAll(todo.title, "\n", "\\n") << endl;
        file << replaceAll(todo.content, "\n", "\\n").c_str() << endl;
        file << todo.date << endl;
        file << (todo.completed ? '1' : '0') << endl;
        file << todo.id << endl;
    }

    file.close();

};