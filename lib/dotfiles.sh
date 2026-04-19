#!/usr/bin/env bash
set -Eeuo pipefail
apply_dotfiles() {
    local source_dir="$1"
    ensure_dir_exists "$source_dir"
    rsync -a --backup --suffix=".pre-pwos" "$source_dir/" "$HOME/"
    if command -v zsh >/dev/null 2>&1; then
        local zsh_path
        zsh_path="$(command -v zsh)"
        if [[ "${SHELL:-}" != "$zsh_path" ]]; then
            chsh -s "$zsh_path" || log_warn "Could not change shell automatically"
        fi
    fi
    log_success "Dotfiles applied"
}
install_pw_cli() {
    local cli_source="$1"
    ensure_file_exists "$cli_source"
    install -Dm755 "$cli_source" "$PW_BIN/pw"
    log_success "pw CLI installed"
}
