#!/bin/zsh

# Install swiftly when not installed
if ! command -v swiftly &> /dev/null; then
    echo "\e[32mswiftly is not installed. Installing swiftly...\e[0m"
    curl -O https://download.swift.org/swiftly/darwin/swiftly.pkg && \
    installer -pkg swiftly.pkg -target CurrentUserHomeDirectory && \
    ~/.swiftly/bin/swiftly init --quiet-shell-followup && \
    . "${SWIFTLY_HOME_DIR:-$HOME/.swiftly}/env.sh" && \
    hash -r
else
    echo "\e[32m[INFO] swiftly is already installed.\e[0m"
fi

SWIFT_VERSION=$(swiftly use | awk '{print $2}')
if [ -z "$(swiftly run swift sdk list | grep android | grep $SWIFT_VERSION)" ]; then
    echo "\e[32mInstalling Swift Android SDK for version $SWIFT_VERSION...\e[0m"
    SDK_URL=$(cat script/mapping.yml | yq ".[\"$SWIFT_VERSION\"].url")
    SDK_CHECKSUM=$(cat script/mapping.yml | yq ".[\"$SWIFT_VERSION\"].checksum")
    swift sdk install $SDK_URL --checksum $SDK_CHECKSUM
else
    echo "\e[32m[INFO] Swift Android SDK for version $SWIFT_VERSION is already installed.\e[0m"
fi

if [ -z "$SDKMAN_DIR" ]; then
    echo "\e[32mSDKMAN! is not installed. Installing SDKMAN!...\e[0m"
    brew install sdkman/tap/sdkman-cli

    echo "\e[32mInitializing SDKMAN!...\e[0m"
    echo 'export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec' | tee -a ~/.zshrc | eval
    echo '[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"' | tee -a ~/.zshrc | eval
    echo 'export JAVA_HOME=${SDKMAN_DIR}/candidates/java/current' | tee -a ~/.zshrc | eval
    echo "\e[32mSDKMAN! installed. You may need to restart your terminal or run 'source ~/.zshrc' to apply changes.\e[0m"
else
    echo "\e[32m[INFO] SDKMAN! is already installed.\e[0m"
    # Somehow `sdk` not found even if it is installed, so we source the init script to make it available in this shell session
    [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
    export JAVA_HOME=${SDKMAN_DIR}/candidates/java/current
fi

sdk env install

echo "\e[32m[INFO] Prepare for Swift-Java...\e[0m"
swift package --package-path lib resolve
./lib/.build/checkouts/swift-java/gradlew \
    --project-dir .build/checkouts/swift-java \
    publishToMavenLocal
