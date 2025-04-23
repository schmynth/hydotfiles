#!/usr/bin/env bash

# Script to install hyprland plugin(s)
# by schmynth
#

scrDir=$(dirname "$(realpath "$0")")
# shellcheck disable=SC1091
if ! source "${scrDir}/global_fn.sh"; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

log_section="Hyprspace"

print_log -info "Info" -b "[install] :: " "Hyprspace Overview"
print_log -info "Info" -b "[install] :: " "dependencies"
sudo pacman -S --needed cmake meson pkg-config cpio
hyprpm update
hyprpm add https://github.com/KZDKM/Hyprspace || print_log -warn -g "[Hyprpm]" -r " add :: could not add repo. Already installed?"
hyprpm enable Hyprspace  || print_log -warn -r " [add] :: could not enable Hyprspace. Already enabled?"
hyprpm -v update
hyprpm reload -nn
