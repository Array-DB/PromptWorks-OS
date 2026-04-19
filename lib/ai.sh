#!/usr/bin/env bash
set -Eeuo pipefail

install_ai_stack() {
    log_step "Installing AI stack"

    if ! command -v ollama >/dev/null 2>&1; then
        curl -fsSL https://ollama.com/install.sh | sh
    fi

    if ! command -v pipx >/dev/null 2>&1; then
        sudo pacman -S --noconfirm --needed python-pipx
    fi

    pipx ensurepath || true

    pipx install openai || pipx upgrade openai || true
    pipx install anthropic || pipx upgrade anthropic || true

    log_success "AI stack installed"
}
