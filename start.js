const Compiler = require("./api/compiler");

const outPath = "C:/Users/Manuel Westermeier/source/repos/next-gen-exe/out"

const root = "src"
const entry = "index.w"

new Compiler({
    root,
    entry,
    outPath,
})