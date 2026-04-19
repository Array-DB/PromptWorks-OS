#!/usr/bin/env bash
set -Eeuo pipefail
enable_declared_services() {
    local file="$1"
    ensure_file_exists "$file"
    while IFS= read -r service; do
        [[ -z "$service" || "$service" =~ ^# ]] && continue
        sudo systemctl enable --now "$service"
        log "Enabled service: $service"
    done < "$file"
    log_success "Declared services enabled"
}
install_systemd_units() {
    local dir="$1"
    ensure_dir_exists "$dir"
    sudo cp "$dir"/*.service "$dir"/*.timer "$PW_SYSTEMD_RENDER_DIR/" 2>/dev/null || true
    log_success "Systemd unit templates staged"
}
render_systemd_units() {
    local src_dir="$ROOT_DIR/systemd"
    mkdir -p "$PW_SYSTEMD_RENDER_DIR"
    sed "s|__PW_USER_HOME__|$PW_USER_HOME|g; s|__PW_USERNAME__|$PW_USERNAME|g; s|__PW_PROJECTS_DIR__|$PW_PROJECTS_DIR|g" \
        "$src_dir/promptworks-update.service" | sudo tee /etc/systemd/system/promptworks-update.service >/dev/null
    sudo cp "$src_dir/promptworks-update.timer" /etc/systemd/system/promptworks-update.timer
    sed "s|__PW_USER_HOME__|$PW_USER_HOME|g; s|__PW_USERNAME__|$PW_USERNAME|g; s|__PW_PROJECTS_DIR__|$PW_PROJECTS_DIR|g" \
        "$src_dir/promptworks-healthcheck.service" | sudo tee /etc/systemd/system/promptworks-healthcheck.service >/dev/null
    sudo cp "$src_dir/promptworks-healthcheck.timer" /etc/systemd/system/promptworks-healthcheck.timer
    sudo systemctl daemon-reload
    log_success "Systemd units rendered and installed"
}
enable_pw_timers() {
    sudo systemctl enable --now promptworks-update.timer
    sudo systemctl enable --now promptworks-healthcheck.timer
    log_success "PromptWorks timers enabled"
}
