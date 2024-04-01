#!/bin/bash

# Define the URL to the file containing the list of development dependencies
DEV_DEPENDENCIES_URL="https://raw.githubusercontent.com/melvynkim/init-frontend-lint/main/assets/npm-dev-dependencies.txt"

# Download the list of dependencies
# Use curl to fetch the content. Ensure curl is installed and available.
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please install curl to continue."
    exit 1
fi

echo "Fetching the list of npm development dependencies..."
DEPENDENCIES=$(curl -sL "$DEV_DEPENDENCIES_URL")

# Check if the curl command succeeded and the string is not empty
if [ -z "$DEPENDENCIES" ]; then
    echo "Failed to fetch the npm development dependencies from: $DEV_DEPENDENCIES_URL"
    exit 1
fi

# Install each dependency listed in the fetched content
echo "$DEPENDENCIES" | while IFS= read -r package; do
    if [ ! -z "$package" ]; then  # Ensure the line is not empty
        echo "Installing $package..."
        npm install --save-dev "$package"
    fi
done

echo "All development dependencies have been installed."
