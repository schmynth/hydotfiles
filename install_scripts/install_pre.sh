#!/usr/bin/env bash
#|---/ /+-------------------------------------+---/ /|#
#|--/ /-| Script to apply pre install configs |--/ /-|#
#|-/ /--| Prasanth Rangan                     |-/ /--|#
#|/ /---+-------------------------------------+/ /---|#

scrDir=$(dirname "$(realpath "$0")")
# shellcheck disable=SC1091
if ! source "${scrDir}/global_fn.sh"; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

flg_DryRun=${flg_DryRun:-0}


## systemd-boot
#if pkg_installed systemd && nvidia_detect && [ "$(bootctl status 2>/dev/null | awk '{if ($1 == "Product:") print $2}')" == "systemd-boot" ]; then
#    print_log -sec "bootloader" -info "detected" "systemd-boot"
#
#    if [ "$(find /boot/loader/entries/ -type f -name '*.conf.hyde.bkp' 2>/dev/null | wc -l)" -ne "$(find /boot/loader/entries/ -type f -name '*.conf' 2>/dev/null | wc -l)" ]; then
#        print_log -g "[bootloader] " -b " :: " "nvidia detected, adding nvidia_drm.modeset=1 to boot option..."
#        find /boot/loader/entries/ -type f -name "*.conf" | while read -r imgconf; do
#            sudo cp "${imgconf}" "${imgconf}.hyde.bkp"
#            sdopt=$(grep -w "^options" "${imgconf}" | sed 's/\b quiet\b//g' | sed 's/\b splash\b//g' | sed 's/\b nvidia_drm.modeset=.\b//g')
#            sudo sed -i "/^options/c${sdopt} quiet splash nvidia_drm.modeset=1" "${imgconf}"
#        done
#    else
#        print_log -y "[bootloader] " -info "skipped" "systemd-boot is already configured..."
#    fi
#fi

# pacman

if [ -f /etc/pacman.conf ] && [ ! -f /etc/pacman.conf.hyde.bkp ]; then
    print_log -g "[PACMAN] " -b "modify :: " "activating multilib, set color and candy in pacman..."

    # shellcheck disable=SC2154
    [ "${flg_DryRun}" -eq 1 ] || sudo cp /etc/pacman.conf /etc/pacman.conf.hyde.bkp
    [ "${flg_DryRun}" -eq 1 ] || sudo sed -i "/^#Color/c\Color\nILoveCandy
    /^#VerbosePkgLists/c\VerbosePkgLists
    /^#ParallelDownloads/c\ParallelDownloads = 5" /etc/pacman.conf
    [ "${flg_DryRun}" -eq 1 ] || sudo sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf

    print_log -g "[PACMAN] " -b "update :: " "packages..."
    [ "${flg_DryRun}" -eq 1 ] || sudo pacman -Syyu
    [ "${flg_DryRun}" -eq 1 ] || sudo pacman -Fy
else
    print_log -sec "PACMAN" -info "skipped" "pacman is already configured..."
fi

#if grep -q '\[chaotic-aur\]' /etc/pacman.conf; then
#    print_log -sec "CHAOTIC-AUR" -info "skipped" "Chaotic AUR entry found in pacman.conf..."
#else
#    prompt_timer 120 "Would you like to install Chaotic AUR? [y/n] | q to quit "
#    is_chaotic_aur=false
#
#    case "${PROMPT_INPUT}" in
#    y | Y)
#        is_chaotic_aur=true
#        ;;
#    n | N)
#        is_chaotic_aur=false
#        ;;
#    q | Q)
#        print_log -sec "Chaotic AUR" -crit "Quit" "Exiting..."
#        exit 1
#        ;;
#    *)
#        is_chaotic_aur=true
#        ;;
#    esac
#    if [ "${is_chaotic_aur}" == true ]; then
#        sudo pacman-key --init
#        sudo "${scrDir}/chaotic_aur.sh" --install
#    fi
#fi
