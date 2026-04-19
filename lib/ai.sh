#!/usr/bin/env bash
set -Eeuo pipefail
install_ai_stack() {
    log_step "Installing AI stack"
    if ! command -v ollama >/dev/null 2>&1; then
        curl -fsSL https://ollama.com/install.sh | sh
    fi
    python -m pip install --user --upgrade pip
    python -m pip install --user openai anthropic requests virtualenv pipx
    "$HOME/.local/bin/pipx" ensurepath || true
    log_success "AI stack installed"
}
