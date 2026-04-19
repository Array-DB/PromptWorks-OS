#!/usr/bin/env bash
set -Eeuo pipefail
apply_shadowlab_baseline() {
    log_step "Applying ShadowLab Networks baseline"
    sudo pacman -S --noconfirm --needed ufw keepassxc gnupg openssh fail2ban firejail apparmor
    sudo systemctl enable --now ufw || true
    sudo ufw default deny incoming || true
    sudo ufw default allow outgoing || true
    sudo ufw --force enable || true
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
        ssh-keygen -t ed25519 -C "array@arraydb.net" -f "$HOME/.ssh/id_ed25519" -N ""
    fi
    chmod 600 "$HOME/.ssh/id_ed25519" 2>/dev/null || true
    chmod 644 "$HOME/.ssh/id_ed25519.pub" 2>/dev/null || true
    log_success "ShadowLab Networks baseline applied"
}
