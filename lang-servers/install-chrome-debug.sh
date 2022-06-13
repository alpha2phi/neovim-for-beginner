#!/usr/bin/sh

INSTALL_FOLDER="$HOME/.local/share/nvim"

# Install vscode-chrome-debug
rm -rf "$INSTALL_FOLDER/vscode-chrome-debug"
git clone https://github.com/Microsoft/vscode-chrome-debug "$INSTALL_FOLDER/vscode-chrome-debug"
cd "$INSTALL_FOLDER/vscode-chrome-debug" && npm install && npm run build
