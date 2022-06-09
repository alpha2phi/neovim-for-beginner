#!/usr/bin/sh

INSTALL_FOLDER="$HOME/.local/share/nvim"

# Install kotlin-debug-adapter
rm -rf "$INSTALL_FOLDER/kotlin-debug-adapter"
git clone https://github.com/fwcd/kotlin-debug-adapter.git "$INSTALL_FOLDER/kotlin-debug-adapter"
cd "$INSTALL_FOLDER/kotlin-debug-adapter" && ./gradlew :adapter:installDist
