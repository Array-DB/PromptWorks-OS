#!/usr/bin/env bash
set -Eeuo pipefail
PW_HOME="$HOME/.local/share/promptworks-os"
PW_STATE="$HOME/.config/promptworks-os"
PW_BIN="$HOME/.local/bin"
PW_MACHINE_NAME=""
PW_BUILD_NR=""
PW_FIRMWARE_REPO=""
PW_BACKUP_SOURCE=""
PW_USERNAME="${USER:-$(whoami)}"
PW_USER_HOME="$HOME"
PW_PROJECTS_DIR="$HOME/Projects"
PW_WORKSPACE_DIR="$HOME/Workspace"
PW_SYSTEMD_RENDER_DIR="$PW_STATE/rendered-systemd"
detect_platform() {
    if [[ ! -f /etc/manjaro-release && ! -f /etc/arch-release ]]; then
        die "PromptWorks-OS currently supports Manjaro/Arch family only."
    fi
    log_success "Platform supported"
}
ensure_base_tools() {
    sudo pacman -Sy --noconfirm --needed curl git rsync base-devel jq
}
load_machine_config() {
    local config_file="$1"
    ensure_file_exists "$config_file"
    source "$config_file"
    : "${PW_MACHINE_NAME:?PW_MACHINE_NAME is required}"
    : "${PW_BUILD_NR:?PW_BUILD_NR is required}"
    : "${PW_FIRMWARE_REPO:?PW_FIRMWARE_REPO is required}"
}
init_pw_dirs() {
    mkdir -p "$PW_HOME" "$PW_STATE" "$PW_BIN" "$PW_PROJECTS_DIR" "$PW_WORKSPACE_DIR" "$PW_USER_HOME/.backup" "$PW_SYSTEMD_RENDER_DIR"
    log_success "PromptWorks-OS directories initialized"
}
write_build_metadata() {
    cat > "$PW_STATE/build-info" <<EOB
PW_MACHINE_NAME=$PW_MACHINE_NAME
PW_BUILD_NR=$PW_BUILD_NR
PW_USERNAME=$PW_USERNAME
INSTALLED_AT=$(date -Iseconds)
EOB
    log_success "Build metadata written"
}
ensure_user_local_bin_in_path() {
    mkdir -p "$PW_BIN"
    if ! grep -qs 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    fi
    if [[ -f "$HOME/.bashrc" ]] && ! grep -qs 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    fi
    export PATH="$HOME/.local/bin:$PATH"
    log_success "User-local bin path ensured"
}
setup_pacman() {
    sudo sed -i 's/^#Color/Color/' /etc/pacman.conf || true
    if grep -q '^#\?ParallelDownloads' /etc/pacman.conf; then
        sudo sed -i 's/^#\?ParallelDownloads.*/ParallelDownloads = 5/' /etc/pacman.conf
    else
        echo 'ParallelDownloads = 5' | sudo tee -a /etc/pacman.conf >/dev/null
    fi
    log_success "Pacman tuned"
}
install_yay_if_missing() {
    if command_exists yay; then
        log "yay already installed"
        return
    fi
    local tmp_dir
    tmp_dir="$(mktemp -d)"
    git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
    pushd "$tmp_dir/yay" >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null
    rm -rf "$tmp_dir"
    log_success "yay installed"
}
configure_git() {
    git config --global init.defaultBranch main
    git config --global pull.rebase false
    git config --global core.editor "code --wait"
    git config --global credential.helper store
    log_success "Git configured"
}
verify_system() {
    local verify_script="$1"
    ensure_file_exists "$verify_script"
    bash "$verify_script"
}
