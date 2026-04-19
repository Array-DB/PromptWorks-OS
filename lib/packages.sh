#!/usr/bin/env bash
set -Eeuo pipefail
install_pacman_packages() {
    local file="$1"
    ensure_file_exists "$file"
    mapfile -t packages < <(grep -Ev '^\s*#|^\s*$' "$file")
    if [[ "${#packages[@]}" -gt 0 ]]; then
        sudo pacman -Syu --noconfirm --needed "${packages[@]}"
    fi
    log_success "Pacman packages installed"
}
install_aur_packages() {
    local file="$1"
    ensure_file_exists "$file"
    mapfile -t packages < <(grep -Ev '^\s*#|^\s*$' "$file")
    if [[ "${#packages[@]}" -gt 0 ]]; then
        yay -S --noconfirm --needed "${packages[@]}"
    fi
    log_success "AUR packages installed"
}
