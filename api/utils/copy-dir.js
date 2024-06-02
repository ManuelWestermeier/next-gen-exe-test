const fs = require("fs")
const path = require("path");
const { exit } = require("process");

const copyFile = (src, dest) => {
    return new Promise((resolve, reject) => {
        fs.copyFile(src, dest, (err) => {
            if (err) {
                reject(err);
            } else {
                resolve();
            }
        });
    });
};

exports.copyDirectory = async (src, dest) => {
    try {
        // Ensure the destination directory exists
        if (!fs.existsSync(dest)) {
            fs.mkdirSync(dest, { recursive: true })
        }

        const entries = fs.readdirSync(src, { withFileTypes: true });

        for (const entry of entries) {
            const srcPath = path.join(src, entry.name);
            const destPath = path.join(dest, entry.name);

            if (entry.isDirectory()) {
                // Recursively copy subdirectory
                await copyDirectory(srcPath, destPath);
            } else {
                // Copy file
                await copyFile(srcPath, destPath);
            }
        }
    } catch (err) {
        console.error(`Error copying directory: ${err}`);
        exit(1)
    }
};