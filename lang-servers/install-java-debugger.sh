#!/usr/bin/sh

INSTALL_FOLDER="$HOME/.local/share/nvim"

# Set this if necessary
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
export PATH="$JAVA_HOME/bin:$PATH"

# Install java-debug
rm -rf "$INSTALL_FOLDER/java-debug"
git clone https://github.com/microsoft/java-debug.git "$INSTALL_FOLDER/java-debug"
cd "$INSTALL_FOLDER/java-debug" && ./mvnw clean install

# Install vscode-java-test
rm -rf "$INSTALL_FOLDER/vscode-java-test"
git clone https://github.com/microsoft/vscode-java-test.git "$INSTALL_FOLDER/vscode-java-test"
cd "$INSTALL_FOLDER/vscode-java-test" && npm install && npm run build-plugin
