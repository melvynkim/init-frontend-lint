#!/bin/bash

# Base URL for fetching configuration files
REPO_BASE_URL="https://raw.githubusercontent.com/melvynkim/init-frontend-lint/main/assets"

# Files to download
FILES_TO_DOWNLOAD=(
  ".eslintrc.js"
  ".lintstagedrc"
  ".markdownlint.json"
  ".prettierignore"
  ".prettierrc"
  ".stylelintrc"
)

echo "Starting lint configuration files setup..."

# Download each file
for FILE in "${FILES_TO_DOWNLOAD[@]}"; do
  echo "Downloading ${FILE}..."
  curl -sL "${REPO_BASE_URL}/${FILE}" -o "${FILE}"
done

echo "Lint configuration files have been set up."

# Install lint-related packages
echo "Installing ESLint, Prettier, Stylelint, and Markdownlint..."

npm install --save-dev eslint prettier stylelint markdownlint-cli eslint-plugin-react eslint-config-prettier stylelint-config-standard

echo "Lint-related NPM packages installed."
