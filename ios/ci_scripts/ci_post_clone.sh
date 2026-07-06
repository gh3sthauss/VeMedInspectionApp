#!/bin/sh
set -e

# Xcode Cloud has no Flutter SDK preinstalled and runs this script with the
# working directory set to ci_scripts/, so move to the repo root first.
cd "$CI_WORKSPACE"

# Install Flutter (stable channel, matching local dev setup).
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:$CI_WORKSPACE/flutter/bin"

flutter precache --ios
flutter pub get

HOMEBREW_NO_AUTO_UPDATE=1 brew install cocoapods
cd ios && pod install
