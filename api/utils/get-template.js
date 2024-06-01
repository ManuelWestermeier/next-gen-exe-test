const { getFileData } = require("./get-file-data")
const path = require("path")

exports.getTemplate = (pathName, fromFilePathName) => {
    const fileData = getFileData(
        path.join(
            path.dirname(fromFilePathName),
            pathName
        )
    )

    var isVar = true;

    return fileData.split("##").map((part) => {

        isVar = !isVar;
        if (isVar)
            return part == "hash" ? '"#"' : part
        return `"${part.split('"').join('\\"').split("\n").join('\\n').split("\r").join('')}"`

    }).join(" + ")
}