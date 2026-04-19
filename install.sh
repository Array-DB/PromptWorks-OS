#!/usr/bin/env bash
set -Eeuo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT_DIR/lib/utils.sh"
source "$ROOT_DIR/lib/core.sh"
source "$ROOT_DIR/lib/packages.sh"
source "$ROOT_DIR/lib/services.sh"
source "$ROOT_DIR/lib/dotfiles.sh"
source "$ROOT_DIR/lib/security.sh"
source "$ROOT_DIR/lib/restore.sh"
source "$ROOT_DIR/lib/updates.sh"
source "$ROOT_DIR/lib/ai.sh"
source "$ROOT_DIR/lib/android.sh"
source "$ROOT_DIR/lib/launcher.sh"
main() {
    print_banner
    require_not_root
    require_sudo
    detect_platform
    ensure_base_tools
    log_step "Starting PromptWorks-OS installation"
    load_machine_config "$ROOT_DIR/config/machine.conf"
    init_pw_dirs
    write_build_metadata
    ensure_user_local_bin_in_path
    setup_pacman
    install_yay_if_missing
    install_pacman_packages "$ROOT_DIR/config/packages.pacman"
    install_aur_packages "$ROOT_DIR/config/packages.aur"
    configure_git
    apply_dotfiles "$ROOT_DIR/dotfiles"
    enable_declared_services "$ROOT_DIR/config/services.enabled"
    install_ai_stack
    install_android_stack
    install_promptworks_launcher
    apply_shadowlab_baseline
    install_pw_cli "$ROOT_DIR/scripts/pw"
    install_systemd_units "$ROOT_DIR/systemd"
    render_systemd_units
    enable_pw_timers
    maybe_restore_home
    sync_firmware_repo
    verify_system "$ROOT_DIR/scripts/verify-system.sh"
    log_success "PromptWorks-OS installation complete"
    echo
    echo "Next commands:"
    echo "  pw status"
    echo "  pw firmware check"
    echo "  pw firmware apply"
    echo "  pw snapshot"
    echo "  pw build"
}
main "$@"
