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

string fileName = ".tododata";

vector<Todo> todos = ([&]() {
    std::vector<Todo> todos;
    std::ifstream file(fileName);

    if (!file.is_open()) {
        std::cerr << "Error opening file: " << fileName << std::endl;
        return todos;
    }

    std::string line;
    Todo todo;

    while (std::getline(file, line)) {
        todo.title = line;

        if (std::getline(file, line)) {
            todo.content = line;
        } else {
            break;
        }

        if (std::getline(file, line)) {
            todo.date = line;
        } else {
            break;
        }

        if (std::getline(file, line)) {
            todo.completed = (line == "1");
        } else {
            break;
        }

        if (std::getline(file, line)) {
            todo.id = std::stoi(line);
        } else {
            break;
        }

        todos.push_back(todo);
    }

    file.close();

    return todos;
})();

auto writeFile = [](string fileName, string data) {

	//open file
	ofstream MyFile(fileName);
	//write file
	MyFile << data;
	//close file
	MyFile.close();

};

auto int2binarystring = [](int number) {
    
};

auto saveTodos = [&]() {
    
    std::ofstream file(fileName);
    
    if (!file.is_open()) {
        std::cerr << "Error opening file: " << std::endl;
        return;
    }

    for (const auto& todo : todos) {
        // Write each Todo item's details to the file
        file << todo.title << std::endl;
        file << todo.content << std::endl;
        file << todo.date << std::endl;
        file << (todo.completed ? '1' : '0') << std::endl;
        file << todo.id << std::endl;
    }

    file.close();

};