// Function to check if the request is from localhost
bool is_localhost(const httplib::Request &req, httplib::Response &res)
{
    std::string remote_ip = req.remote_addr;
    if (req.remote_addr == "127.0.0.1" || req.remote_addr == "::1" || req.remote_addr == "localhost")
        return true;
    res.status = 403; // Forbidden
    // res.set_content("Forbidden", "text/plain");
    return false;
}

// Middleware-like function to wrap around request handlers
auto make_localhost_handler = [](auto handler)
{
    return [handler](const httplib::Request &req, httplib::Response &res)
    {
        if (is_localhost(req, res))
        {
            handler(req, res);
        }
    };
};

void serve_public(httplib::Server &server, const std::string &mount_point, const std::string &dir)
{
    // Set the mount point for serving static files
    server.set_mount_point(mount_point, dir);
    server.set_file_request_handler(is_localhost);
}

void run(Server *server, int port, const std::string &rootPath)
{
    // Construct the command to open the URL in the default web browser
    std::string runCmd = "start http://localhost:" + std::to_string(port) + rootPath;
    cout << "running at " << "http://localhost:" << std::to_string(port) << rootPath << endl;
    system(runCmd.c_str());

    // Start the server and listen on the specified port
    if (!server->listen("0.0.0.0", port))
    {
        std::cerr << "Error: Failed to start the server on port " << port << std::endl;
    }
}