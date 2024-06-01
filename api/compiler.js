const path = require("path")
const fs = require("fs")
const { error } = require("console")
const { getFileData } = require("./utils/get-file-data")

module.exports = class Compiler {

    fileHeader = ""

    constructor({
        root = "src",
        entry = "index.w",
        config = "config.json",
        outPath = "out"
    }) {

        this.config = JSON.parse(fs.readFileSync(
            path.join(root, config),
            "utf-8"
        ))

        this.indexFilePath = path.join(root, entry)
        this.outFilePath = outPath

        this.compile()
    }

    compile() {

        const clientCode = this.compileFile(this.indexFilePath)
        fs.writeFileSync(this.outFilePath, `${fs.readFileSync("api/httplib.h", "utf-8")}
        ${fs.readFileSync("api/std.cpp", "utf-8")}
        //client header
        ${this.fileHeader}
        //client code
        int main(int argc, char** argv) {
            ${clientCode}
        }`, "utf-8")

    }

    compileFile(pathName) {

        const fileData = getFileData(pathName)

        return fileData

    }

}