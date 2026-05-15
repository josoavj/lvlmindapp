#!/bin/bash
# LevelMind Release Automation Scripts
# Usage: ./release.sh [command] [version]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="LevelMind"
GITHUB_REPO="josoavj/lvlmindapp"
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
    exit 1
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Print header
print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Command: check
cmd_check() {
    print_header "Checking Environment"
    
    # Check Flutter
    if command -v flutter &> /dev/null; then
        FLUTTER_VERSION=$(flutter --version | head -n1)
        log_success "Flutter: $FLUTTER_VERSION"
    else
        log_error "Flutter not found. Install from https://flutter.dev"
    fi
    
    # Check Dart
    if command -v dart &> /dev/null; then
        DART_VERSION=$(dart --version 2>&1)
        log_success "Dart: $DART_VERSION"
    else
        log_error "Dart not found"
    fi
    
    # Check Git
    if command -v git &> /dev/null; then
        GIT_VERSION=$(git --version)
        log_success "Git: $GIT_VERSION"
    else
        log_error "Git not found"
    fi
    
    # Check Android SDK (optional)
    if command -v adb &> /dev/null; then
        log_success "Android SDK: Found"
    else
        log_warning "Android SDK: Not found (optional)"
    fi
    
    # Check Xcode (optional)
    if command -v xcode-select &> /dev/null; then
        log_success "Xcode: Found"
    else
        log_warning "Xcode: Not found (optional)"
    fi
    
    print_header "Analysis"
    
    cd "$CURRENT_DIR"
    flutter analyze || log_error "Flutter analyze failed"
    log_success "Flutter analyze: OK"
}

# Command: clean
cmd_clean() {
    print_header "Cleaning Project"
    
    cd "$CURRENT_DIR"
    
    log_info "Removing build directories..."
    rm -rf build/
    rm -rf ios/Pods/
    rm -rf .dart_tool/
    
    log_info "Running flutter clean..."
    flutter clean
    
    log_success "Project cleaned"
}

# Command: deps
cmd_deps() {
    print_header "Installing Dependencies"
    
    cd "$CURRENT_DIR"
    
    log_info "Running flutter pub get..."
    flutter pub get
    
    log_info "Generating code..."
    flutter pub run build_runner build --delete-conflicting-outputs
    
    log_success "Dependencies installed"
}

# Command: test
cmd_test() {
    print_header "Running Tests"
    
    cd "$CURRENT_DIR"
    
    log_info "Running unit tests..."
    flutter test --coverage
    
    if command -v lcov &> /dev/null; then
        log_info "Generating coverage report..."
        lcov --list coverage/lcov.info | tail -n5
    fi
    
    log_success "Tests completed"
}

# Command: build
cmd_build() {
    local VERSION=$1
    
    if [ -z "$VERSION" ]; then
        log_error "Version not specified. Usage: $0 build <version>"
    fi
    
    print_header "Building Release for v$VERSION"
    
    cd "$CURRENT_DIR"
    
    # Clean first
    log_info "Cleaning previous builds..."
    flutter clean
    
    # Android
    log_info "Building Android APK..."
    flutter build apk --release --build-number=$(date +%s)
    
    if [ -f "build/app/outputs/flutter-app.apk" ]; then
        log_success "Android APK built"
        APK_SIZE=$(du -h build/app/outputs/flutter-app.apk | cut -f1)
        log_info "APK size: $APK_SIZE"
    else
        log_error "Android APK build failed"
    fi
    
    # Android Bundle
    log_info "Building Android App Bundle..."
    flutter build appbundle --release
    
    if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
        log_success "Android App Bundle built"
        AAB_SIZE=$(du -h build/app/outputs/bundle/release/app-release.aab | cut -f1)
        log_info "AAB size: $AAB_SIZE"
    else
        log_error "Android App Bundle build failed"
    fi
    
    # iOS
    log_info "Building iOS Release..."
    flutter build ios --release
    
    if [ -d "build/ios/iphoneos/Runner.app" ]; then
        log_success "iOS app built"
    else
        log_error "iOS build failed"
    fi
    
    log_success "All builds completed successfully"
}

# Command: sign
cmd_sign() {
    local APK_PATH=$1
    local KEYSTORE_PATH="${HOME}/.android/release-key.jks"
    local KEY_ALIAS="lvlmind_key"
    
    if [ -z "$APK_PATH" ]; then
        APK_PATH="build/app/outputs/flutter-app.apk"
    fi
    
    if [ ! -f "$APK_PATH" ]; then
        log_error "APK not found: $APK_PATH"
    fi
    
    print_header "Signing APK"
    
    if [ ! -f "$KEYSTORE_PATH" ]; then
        log_warning "Keystore not found. Creating new keystore..."
        keytool -genkey -v -keystore "$KEYSTORE_PATH" \
            -keyalg RSA -keysize 2048 \
            -validity 10000 \
            -alias "$KEY_ALIAS"
    fi
    
    log_info "Signing APK with keystore..."
    jarsigner -verbose \
        -sigalg SHA256withRSA \
        -digestalg SHA-256 \
        -keystore "$KEYSTORE_PATH" \
        "$APK_PATH" \
        "$KEY_ALIAS"
    
    log_success "APK signed successfully"
    
    # Optional: Align APK
    if command -v zipalign &> /dev/null; then
        log_info "Aligning APK..."
        OUTPUT_PATH="${APK_PATH%.apk}-aligned.apk"
        zipalign -v 4 "$APK_PATH" "$OUTPUT_PATH"
        log_success "APK aligned: $OUTPUT_PATH"
    fi
}

# Command: version
cmd_version() {
    local VERSION=$1
    
    if [ -z "$VERSION" ]; then
        log_error "Version not specified. Usage: $0 version <version>"
    fi
    
    print_header "Updating Version to $VERSION"
    
    cd "$CURRENT_DIR"
    
    # Update pubspec.yaml
    log_info "Updating pubspec.yaml..."
    CURRENT_VERSION=$(grep '^version:' pubspec.yaml | cut -d' ' -f2)
    BUILD_NUMBER=$(echo $CURRENT_VERSION | rev | cut -d'+' -f2 | rev)
    BUILD_NUMBER=$((BUILD_NUMBER + 1))
    
    sed -i "s/^version:.*/version: $VERSION+$BUILD_NUMBER/" pubspec.yaml
    log_success "pubspec.yaml updated"
    
    # Update Android
    log_info "Updating Android version..."
    sed -i "s/versionCode .*/versionCode $BUILD_NUMBER/" android/app/build.gradle
    sed -i "s/versionName .*/versionName \"$VERSION\"/" android/app/build.gradle
    log_success "Android version updated"
    
    # Update iOS
    log_info "Updating iOS version..."
    sed -i "" "s/<string>.*<\/string>/<string>$VERSION<\/string>/" ios/Runner/Info.plist 2>/dev/null || \
    sed -i "s/<string>.*<\/string>/<string>$VERSION<\/string>/" ios/Runner/Info.plist
    log_success "iOS version updated"
    
    log_success "Version updated to $VERSION+$BUILD_NUMBER"
}

# Command: tag
cmd_tag() {
    local VERSION=$1
    
    if [ -z "$VERSION" ]; then
        log_error "Version not specified. Usage: $0 tag <version>"
    fi
    
    print_header "Creating Git Tag for v$VERSION"
    
    cd "$CURRENT_DIR"
    
    # Check if tag exists
    if git rev-parse "v$VERSION" >/dev/null 2>&1; then
        log_error "Tag v$VERSION already exists"
    fi
    
    log_info "Creating annotated tag..."
    git tag -a "v$VERSION" -m "Release version $VERSION"
    
    log_info "Pushing tag..."
    git push origin "v$VERSION"
    
    log_success "Tag v$VERSION created and pushed"
}

# Command: status
cmd_status() {
    print_header "Release Status"
    
    cd "$CURRENT_DIR"
    
    # Get current version
    CURRENT_VERSION=$(grep '^version:' pubspec.yaml | cut -d' ' -f2)
    log_info "Current version: $CURRENT_VERSION"
    
    # Get latest tag
    LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "No tags yet")
    log_info "Latest tag: $LATEST_TAG"
    
    # Check git status
    log_info "Git status:"
    if [ -z "$(git status --porcelain)" ]; then
        log_success "Working directory clean"
    else
        log_warning "Working directory has changes"
        git status --short
    fi
    
    # Check build artifacts
    log_info "Build artifacts:"
    if [ -f "build/app/outputs/flutter-app.apk" ]; then
        APK_SIZE=$(du -h build/app/outputs/flutter-app.apk | cut -f1)
        log_info "  APK: $APK_SIZE"
    fi
    
    if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
        AAB_SIZE=$(du -h build/app/outputs/bundle/release/app-release.aab | cut -f1)
        log_info "  AAB: $AAB_SIZE"
    fi
}

# Command: help
cmd_help() {
    cat << 'EOF'

🎓 LevelMind Release Tool

Usage: ./release.sh [command] [options]

Commands:

  check              Verify environment setup
  clean              Clean build artifacts
  deps               Install dependencies
  test               Run tests with coverage
  build <version>    Build APK, AAB, and iOS
  sign [apk-path]    Sign APK with keystore
  version <version>  Update version numbers
  tag <version>      Create git tag
  status             Show release status
  help               Show this help message

Examples:

  ./release.sh check
  ./release.sh clean
  ./release.sh deps
  ./release.sh test
  ./release.sh build 1.0.0-beta.2
  ./release.sh sign build/app/outputs/flutter-app.apk
  ./release.sh version 1.0.0-beta.2
  ./release.sh tag 1.0.0-beta.2
  ./release.sh status

Full Release Workflow:

  1. ./release.sh check          # Verify setup
  2. ./release.sh clean          # Clean build
  3. ./release.sh deps           # Get dependencies
  4. ./release.sh test           # Run tests
  5. ./release.sh version 1.0.0  # Update version
  6. ./release.sh build 1.0.0    # Build all platforms
  7. ./release.sh sign           # Sign APK
  8. ./release.sh tag 1.0.0      # Create tag

Notes:

  - Version format: MAJOR.MINOR.PATCH[-PRERELEASE]
  - Examples: 1.0.0, 1.0.0-beta.1, 1.1.0-rc.1
  - APK signing requires keystore at ~/.android/release-key.jks
  - To create keystore: keytool -genkey -v -keystore ~/.android/release-key.jks ...

Resources:

  Documentation: ./RELEASE_GUIDE.md
  Architecture: ./ARCHITECTURE_OVERVIEW.md
  Changelog: ./CHANGELOG.md

Author: @josoavj
Last Updated: 2025-11-29

EOF
}

# Main
main() {
    local COMMAND=$1
    shift
    
    case "$COMMAND" in
        check)
            cmd_check "$@"
            ;;
        clean)
            cmd_clean "$@"
            ;;
        deps)
            cmd_deps "$@"
            ;;
        test)
            cmd_test "$@"
            ;;
        build)
            cmd_build "$@"
            ;;
        sign)
            cmd_sign "$@"
            ;;
        version)
            cmd_version "$@"
            ;;
        tag)
            cmd_tag "$@"
            ;;
        status)
            cmd_status "$@"
            ;;
        help|--help|-h)
            cmd_help
            ;;
        *)
            if [ -z "$COMMAND" ]; then
                log_error "No command specified. Use './release.sh help' for usage."
            else
                log_error "Unknown command: $COMMAND"
            fi
            ;;
    esac
}

# Run main if script is executed directly
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    main "$@"
fi
