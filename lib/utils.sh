#!/usr/bin/env bash
set -Eeuo pipefail
log() { printf '[INFO] %s\n' "$*"; }
log_step() { printf '\n[STEP] %s\n' "$*"; }
log_warn() { printf '[WARN] %s\n' "$*" >&2; }
log_error() { printf '[ERROR] %s\n' "$*" >&2; }
log_success() { printf '[OK] %s\n' "$*"; }
die() { log_error "$*"; exit 1; }
print_banner() {
cat <<'EOB'
========================================
           P R O M P T W O R K S - O S
       Firmware-Works + ShadowLab Networks
========================================
EOB
}
require_not_root() { [[ "${EUID}" -eq 0 ]] && die "Run as your normal user, not root."; }
require_sudo() { sudo -v || die "Sudo authentication failed."; }
command_exists() { command -v "$1" >/dev/null 2>&1; }
ensure_file_exists() { [[ -f "$1" ]] || die "Missing required file: $1"; }
ensure_dir_exists() { [[ -d "$1" ]] || die "Missing required directory: $1"; }
