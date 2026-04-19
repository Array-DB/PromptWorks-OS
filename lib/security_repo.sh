#!/usr/bin/env bash
set -Eeuo pipefail

security_checkout_dir() {
    printf '%s\n' "$PW_HOME/security-details"
}

sync_security_repo() {
    local dest
    dest="$(security_checkout_dir)"

    if [[ -d "$dest/.git" ]]; then
        git -C "$dest" fetch --all --tags
        git -C "$dest" pull --ff-only
    else
        git clone "$PW_SECURITY_REPO" "$dest" || log_warn "Could not clone PromptWorks security details repo"
    fi

    log_success "PromptWorks security details sync step complete"
}
