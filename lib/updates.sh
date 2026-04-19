#!/usr/bin/env bash
set -Eeuo pipefail
firmware_checkout_dir() {
    printf '%s\n' "$PW_HOME/firmware-works"
}
sync_firmware_repo() {
    local dest
    dest="$(firmware_checkout_dir)"
    if [[ -d "$dest/.git" ]]; then
        git -C "$dest" fetch --all --tags
        git -C "$dest" pull --ff-only
    else
        git clone "$PW_FIRMWARE_REPO" "$dest" || log_warn "Could not clone Firmware-Works yet"
    fi
    log_success "Firmware-Works sync step complete"
}
run_firmware_updates() {
    local dest
    dest="$(firmware_checkout_dir)"
    sync_firmware_repo
    if [[ -x "$dest/apply-updates.sh" ]]; then
        bash "$dest/apply-updates.sh"
        log_success "Firmware-Works updates applied"
    else
        log_warn "No apply-updates.sh found in Firmware-Works repo"
    fi
}
