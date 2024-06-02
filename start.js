const Compiler = require("./api/compiler");

new Compiler({
    root: "src",
    entry: "index.w",
    outPath: false ? "out" : "C:/Users/Manuel Westermeier/source/repos/next-gen-exe/out"
})