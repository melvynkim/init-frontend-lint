#!/bin/bash

# Check for package.json to ensure it's an NPM package
if [[ ! -f "package.json" ]]; then
  echo "package.json not found. Please run this script in the root directory of an NPM package."
  exit 1
fi

# Validate package.json
if ! jq empty package.json &> /dev/null; then
  echo "Invalid package.json. Please ensure your package.json is valid JSON."
  exit 1
fi

# Prompt for overwriting existing configuration files
read -p "This setup might overwrite existing lint configuration files. Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi

# Run setup scripts
bash <(curl -sL https://raw.githubusercontent.com/melvynkim/init-frontend-lint/main/scripts/setup_lint_files.sh)
bash <(curl -sL https://raw.githubusercontent.com/melvynkim/init-frontend-lint/main/scripts/update_package_json.sh)
bash <(curl -sL https://raw.githubusercontent.com/melvynkim/init-frontend-lint/main/scripts/install_dev_dependencies.sh)
