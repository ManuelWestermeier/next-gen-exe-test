void run(Server *server, int port, const std::string &rootPath)
{
    // Construct the command to open the URL in the default web browser
    std::string runCmd = "start http://localhost:" + std::to_string(port) + rootPath;
    system(runCmd.c_str());

    // Start the server and listen on the specified port
    if (!server->listen("0.0.0.0", port))
    {
        std::cerr << "Error: Failed to start the server on port " << port << std::endl;
    }
}