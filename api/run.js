const { cpp } = require('compile-run');

module.exports = function (path, compilationPath) {
    //If I want to provide custom path of gcc in cpp
    cpp.runFile(path, {
        compilationPath
    }, (err, result) => console.log(err ? err : result));
}