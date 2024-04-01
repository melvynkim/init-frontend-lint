#!/bin/bash

# Define the URL to the package-scripts.json in the GitHub repository
SCRIPTS_JSON_URL="https://raw.githubusercontent.com/melvynkim/init-frontend-lint/main/assets/package-scripts.json"

# Define the local path for the downloaded package-scripts.json
SCRIPTS_JSON="package-scripts.json"

# Ensure jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Please install jq to continue."
    exit 1
fi

# Download package-scripts.json from GitHub
echo "Downloading package-scripts.json..."
if ! curl -sL "$SCRIPTS_JSON_URL" -o "$SCRIPTS_JSON"; then
    echo "Failed to download package-scripts.json."
    exit 1
fi

# Find package.json in the current directory
MAIN_PKG_JSON="package.json"
if [ ! -f "$MAIN_PKG_JSON" ]; then
    echo "package.json does not exist in the current directory."
    exit 1
fi

# Merge the script configurations into the main package.json
echo "Updating package.json with new scripts..."
if ! jq --slurpfile newScripts "$SCRIPTS_JSON" '.scripts += $newScripts[0]' "$MAIN_PKG_JSON" > temp_pkg.json; then
    echo "Failed to update package.json."
    rm -f "$SCRIPTS_JSON"  # Clean up the downloaded scripts file
    exit 1
fi

# Move the temporary file to replace the original package.json
mv temp_pkg.json "$MAIN_PKG_JSON"

# Clean up the downloaded scripts file
rm -f "$SCRIPTS_JSON"

echo "Scripts successfully added to package.json."
