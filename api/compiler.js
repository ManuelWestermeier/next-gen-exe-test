const path = require("path")
const fs = require("fs")
const { error } = require("console")
const { getFileData } = require("./utils/get-file-data")
const { getFunctionFromLine } = require("./utils/get-function-from-line")
const { exit } = require("process")
const { getTemplate } = require("./utils/get-template")
const { copyDirectory } = require("./utils/copy-dir")

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
        this.outFilePath = path.join(outPath, "index.cpp")

        this.assetsDir = path.join(root, this.config.assets)
        this.outAssetsDir = path.join(outPath, this.config.assets)

        this.compile()
    }

    compile() {

        const clientCode = this.compileFile(this.indexFilePath)

        const directoryPath = path.dirname(this.outFilePath);

        // Remove the directory and its contents
        if (fs.existsSync(directoryPath)) {
            fs.rmSync(directoryPath, { recursive: true, force: true });
        }

        // Create the directory
        fs.mkdirSync(directoryPath, { recursive: true });

        fs.writeFileSync(this.outFilePath,
            `${fs.readFileSync("api/httplib.h", "utf-8")}
            ${fs.readFileSync("api/std.cpp", "utf-8")}
            //client header
            ${this.fileHeader}
            //client code
            int main(int argc, char** argv) {
                ${clientCode}
            }`,
            "utf-8")

        copyDirectory(this.assetsDir, this.outAssetsDir)

    }

    compileFile(pathName) {

        const fileData = getFileData(pathName)

        return fileData.split(/\r\n|\n/g).map((_line, lineIndex) => {

            const [fn, line] = getFunctionFromLine(_line)

            if (fn == "@import") {

                const pathToFile = line.split(/ |\t/g)[1]

                return this.compileFile(
                    path.join(
                        path.dirname(pathName),
                        pathToFile
                    )
                )

            }
            else if (fn == "@template") {

                const args = line.split(/ |\t/g)

                if (args[2] != "from" || args.length != 4) {
                    error(`${pathName}:${lineIndex} error template syntax`)
                    exit(1)
                }

                return `string ${args[1]} = ${getTemplate(args[3], pathName)};`

            }
            else if (fn == "@top") {
                const lineWithoutFn = line.split(" ")
                this.fileHeader += lineWithoutFn.slice(1, lineWithoutFn.length).join(" ") + "\n"
            }

            else return line

        }).join("\n")

    }

}