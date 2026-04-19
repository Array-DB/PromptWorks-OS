#!/usr/bin/env bash
set -Eeuo pipefail
install_android_stack() {
    log_step "Installing Android stack"
    yay -S --noconfirm --needed android-studio android-sdk-platform-tools android-tools
    mkdir -p "$HOME/Android/Sdk"
    log_success "Android tooling installed"
}
