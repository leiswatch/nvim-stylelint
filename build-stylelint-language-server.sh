#!/usr/bin/env bash

# Version of vscode-stylelint to use
VSCODE_STYLELINT_VERSION="2.0.2"

# Check if --debug option is provided
DEBUG_MODE=false
if [ "$1" == "--debug" ]; then
    DEBUG_MODE=true
fi

# Clone the repository
rm -rf vscode-stylelint
git clone https://github.com/stylelint/vscode-stylelint.git

# Checkout the given release version
cd vscode-stylelint || exit
git checkout "tags/${VSCODE_STYLELINT_VERSION}"

# Install dependencies and build the language server
npm install
npm run build-bundle

# If not in debug mode, clean up unnecessary files
if [ "$DEBUG_MODE" == "false" ]; then
    cd ..
    # echo "Cleaning up the repository except for ./vscode-stylelint/dist/..."
    find ./vscode-stylelint -mindepth 1 ! -regex '^./vscode-stylelint/dist\(/.*\)?' ! -regex '^./vscode-stylelint/LICENSE' -delete
else
    echo "Skipping cleanup due to --debug mode."
fi
