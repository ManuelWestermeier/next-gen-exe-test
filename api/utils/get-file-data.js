const { error } = require("console")
const fs = require("fs")
const { exit } = require("process")

exports.getFileData = (pathName) => {

    if (!fs.existsSync(pathName)) {
        error(`file : ${pathName} not exists`)
        exit(1)
    }

    const fileData = fs.readFileSync(pathName, "utf-8")

    return fileData

}