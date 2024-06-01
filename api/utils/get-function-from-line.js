exports.getFunctionFromLine = (line = "") => {
    // Trim leading spaces and tabs from the line
    const trimmedLine = line.trim();

    // Split the line into words based on spaces
    const words = trimmedLine.split(/\s+/);

    // Extract the function name (assuming it is the second word)
    const functionName = words[0];

    return [functionName, trimmedLine];
}