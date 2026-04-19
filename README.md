# PromptWorks-OS

PromptWorks-OS is a reproducible developer operating system layer for Manjaro GNOME.

## Naming
- PromptWorks-OS = machine platform
- Firmware-Works = firmware-style update channel
- ShadowLab Networks = security and hardening layer

## Features
- one-command bootstrap
- package manifests
- service activation
- AI tooling install
- Android tooling install
- PromptWorks launcher sync
- ShadowLab baseline hardening
- firmware update lane
- health checks
- snapshot command
- restore support

## Requirements
- Manjaro or Arch-based system
- sudo access
- internet access
- GitHub SSH configured if using private repos

## Install
git clone git@github.com:Array-DB/PromptWorks-OS.git
cd PromptWorks-OS
./install.sh

## Firmware updates
The Firmware-Works repo should contain this file at repo root:

apply-updates.sh

## Release example
git add .
git commit -m "PromptWorks-OS v1 bootstrap"
git tag -a promptworks-os-v1.0.0 -m "PromptWorks-OS v1.0.0"
git push origin main
git push origin promptworks-os-v1.0.0
