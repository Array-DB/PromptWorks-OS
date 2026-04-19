# PromptWorks-OS

PromptWorks-OS is a reproducible developer operating system layer for Manjaro GNOME.

## Stack
- PromptWorks-OS = machine bootstrap layer
- Firmware-Works = firmware-style update lane
- ShadowLab Networks = security and hardening identity

## What it does
- installs core development packages
- installs AUR packages
- applies user dotfiles
- enables required system services
- installs AI tooling
- installs Android tooling
- syncs PromptWorks launcher
- applies ShadowLab baseline hardening
- syncs Firmware-Works
- installs health-check and update timers

## Repository layout
- install.sh = single entrypoint
- config/ = machine definition
- lib/ = installer modules
- scripts/pw = local control CLI
- systemd/ = timer and service templates
- dotfiles/ = shell and editor defaults

## Requirements
- Manjaro or Arch-based Linux
- sudo access
- internet access
- GitHub SSH configured

## Install
git clone git@github-pwos:Array-DB/PromptWorks-OS.git
cd PromptWorks-OS
./install.sh

## Notes
This is the v1 bootstrap foundation. First-run testing may still expose package-name or environment-specific issues. That is normal for early field validation.

## Release
Current release tag:
- promptworks-os-v1.0.0
