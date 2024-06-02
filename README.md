# next-gen-exe

## usage

Technology: [http server and client](https://github.com/yhirose/cpp-httplib/blob/master/README.md)

## code

### the server setup

1. set in the start.js file the compiler setup

```js
const Compiler = require("./api/compiler");

new Compiler({
    //the root path of the source code dir
    root: "src",
    //the index file in the source code dir
    entry: "index.w",
    //output path
    outPath: false ? "out" : "C:/Users/Manuel Westermeier/source/repos/next-gen-exe/out"
})
```

2. 