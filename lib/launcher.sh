#!/usr/bin/env bash
set -Eeuo pipefail
install_promptworks_launcher() {
    log_step "Installing PromptWorks launcher"
    local dest="$PW_PROJECTS_DIR/promptworks-launcher"
    if [[ -d "$dest/.git" ]]; then
        git -C "$dest" pull --ff-only
    else
        git clone https://github.com/array-db/promptworks-launcher.git "$dest" || log_warn "PromptWorks launcher clone failed. Check repo URL or access."
    fi
    log_success "PromptWorks launcher step finished"
}
