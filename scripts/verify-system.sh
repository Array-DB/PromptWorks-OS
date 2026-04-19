#!/usr/bin/env bash
set -Eeuo pipefail
check_cmd() {
    local cmd="$1"
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "[OK] $cmd"
    else
        echo "[WARN] missing $cmd"
    fi
}
check_service() {
    local svc="$1"
    if systemctl is-enabled "$svc" >/dev/null 2>&1; then
        echo "[OK] enabled: $svc"
    else
        echo "[WARN] not enabled: $svc"
    fi
}
check_cmd git
check_cmd docker
check_cmd node
check_cmd python
check_cmd code
check_cmd ollama
check_service docker.service
check_service postgresql.service
check_service valkey.service
