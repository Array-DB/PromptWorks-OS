#!/usr/bin/env bash
set -Eeuo pipefail
maybe_restore_home() {
    if [[ -n "${PW_BACKUP_SOURCE:-}" && -d "${PW_BACKUP_SOURCE:-}" ]]; then
        log_step "Restoring from backup source"
        rsync -a --info=progress2 --exclude ".cache" --exclude ".local/share/Trash" --exclude "node_modules" --exclude ".venv" "$PW_BACKUP_SOURCE/" "$HOME/"
        log_success "Backup restore completed"
    else
        log "No restore source configured; skipping restore"
    fi
}
