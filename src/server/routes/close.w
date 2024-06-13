@top #include <thread>
@top #include <future>
@top #include <chrono>

server.Get("/close", make_localhost_handler([&](const Request req, Response &res) {
    
    @template page from ../../frontend/closed.html

    res.set_content(page, "text/html");

    std::async(std::launch::async, [&] {
        cout << "closing" << endl;
        std::this_thread::sleep_for(std::chrono::seconds(1));
        server.stop();
    });

    saveTodos();
}));

////$(SolutionDir)$(Platform)\$(Configuration)