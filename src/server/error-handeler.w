server.set_error_handler([](const auto& req, auto& res) {
  auto fmt = "<p>Error Status: <span style='color:red;'>%d</span></p>";
  char buf[BUFSIZ];
  snprintf(buf, sizeof(buf), fmt, res.status);
  res.set_content(buf, "text/html");
});

server.set_exception_handler([](const auto& req, auto& res, std::exception_ptr ep) {
  auto fmt = "<h1>Error 500</h1><p>%s</p>";
  char buf[BUFSIZ];
  try {
    std::rethrow_exception(ep);
  } catch (std::exception &e) {
    snprintf(buf, sizeof(buf), fmt, e.what());
  } catch (...) { // See the following NOTE
    snprintf(buf, sizeof(buf), fmt, "Unknown Exception");
  }
  res.set_content(buf, "text/html");
  res.status = StatusCode::InternalServerError_500;
});