# next-gen-exe

## usage

Technology: [http server and client](https://github.com/yhirose/cpp-httplib/blob/master/README.md)

## code

### the server setup

### 1. set in the start.js file the compiler setup

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

### 2. create in the source dir a config.json file

Every *.w file and template-file is compiled to the {outputPath}/index.cpp file.

But all files in the {assets} dir are copied into the {outputPath}/{assets}.

If you want to have a other dir than {"assets"} you can set it here

```json
{
    "assets": "assets"
}
```

### 3. the {root}/{entry} w-script file is entry of the application

The compiler put all the (c++) code of this file, the imports of this file and the templates in the c++ main function.

output = 
```
{code of "api/httplib.h"}
{code of "api/std.cpp"}
{code of the @top compiler function}
int main(int argc, char** argv) {
    {compiled code}
    return 0;
}
```

#### Scripting .w

```cpp
//the @top compiler function set the content of the following line on top of the (c++) main function
@top #define xy "some random thing"

//create a server
Server server;

int trafficCount = 0;

//main page
server.Get("/", make_localhost_handler([&](const Request req, Response &res) {
  //the @template compiler function is used to to create a template string
  //argument 1 is the c++ variable name for the output 
    //(the name can directly be used as string in the following code & its verry performant)
  //argument 2 is from
  //argument 3 is the path to the template 
  @template ct from frontend/index.html
  
  trafficCount++;

  res.set_content(ct, "text/html");
}));

//assets public serverd
//argument 1 is the server to start and open
//argument 2 is the server url mount point
//argument 3 is the fs path of the files to publish
serve_public(server, "/assets", "./assets");

//the @import compiler function is used to import a .w file 
    //(the import statement is directly replaced by the content of the importcodefile)
//argument 1 is the file path
@import server/error-handeler.w

//run the server on port 5678 with root path /
run(&server, 5678, "/");
```

#### Scripting for template files

the template files are directly compiled to c++ strings

using syntax : 

```cpp
@template { c++ string variable } from { path to template file (it can have all extensions) }
```

in the template file

```txt
Hallo World ## your c++ expression ##
```

if you want to use a ## in the template file you use ##dbhash##

bsp:

test.w
```cpp
string name = "Manuel";
int age = 14;

@template x from x.txt

cout << x << endl;
```

x.txt
```txt
##dbhash####name## is ##sf(age)## years old.
```

returns:
```cpp
string name = "Manuel";
int age = 14;

string x = "##" + name + " is " + to_string(age) + " years old."; 
```

terminal output : 
```txt
##Manuel is 14 years old.
```

### 4. Run

Compile the outputfile with some c++ compiler 

(I use Visual Strudio)

make shure that the executable is in the folder with the assets folder

Then run the executable