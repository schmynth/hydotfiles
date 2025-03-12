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

print_log -g "[Hyprspace]" -b "install :: " "Hyprspace Overview"
print_log -g "[Hyprpm]" -b "install :: " "dependencies"
sudo pacman -S --needed cmake meson pkg-config cpio
hyprpm update
hyprpm add https://github.com/KZDKM/Hyprspace
hyprpm enable Hyprspace
hyprpm -v update
