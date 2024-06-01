#include <string>

#ifdef _WIN32
#include <windows.h>
#else
#include <cstdlib>
#endif

void run(Server *server, int port, const std::string& rootPath)
{
    // Construct the URL
    std::string url = "http://localhost:" + std::to_string(port) + rootPath;

#ifdef _WIN32
    // Use ShellExecute to open the URL in the default browser without showing a console window on Windows
    ShellExecute(0, 0, url.c_str(), 0, 0, SW_SHOWDEFAULT);
#else
    // For other systems, use system call (this will still show a console window)
    std::string runCmd = "xdg-open " + url;  // For Linux
    system(runCmd.c_str());
#endif

    // Start the server and listen on the specified port
    if (!server->listen("0.0.0.0", port))
    {
        std::cerr << "Error: Failed to start the server on port " << port << std::endl;
    }
}
