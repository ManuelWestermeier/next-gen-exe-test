const Compiler = require("./api/compiler");

new Compiler({
    root: "src",
    entry: "index.w",
    outPath: true ? "out" : "C:/Users/Manuel Westermeier/source/repos/next-gen-exe/out"
})