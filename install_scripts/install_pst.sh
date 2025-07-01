#!/usr/bin/env bash
#|---/ /+--------------------------------------+---/ /|#
#|--/ /-| Script to apply post install configs |--/ /-|#
#|-/ /--| schmynth (based on Prasanth Rangan)  |-/ /--|#
#|/ /---+--------------------------------------+/ /---|#


scrDir=$(dirname "$(realpath "$0")")
lstDir="${scrDir}/lists"
# shellcheck disable=SC1091
if ! source "${scrDir}/global_fn.sh"; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

cloneDir="${cloneDir:-$CLONE_DIR}"

# sddm
if pkg_installed sddm; then
    SDDM_ICON_PATH="/var/lib/AccountsService/icons"

    print_log -c "[DISPLAYMANAGER] " -info "Info" -g "detected :: " "sddm"
    if [ ! -d /etc/sddm.conf.d ]; then
        sudo mkdir -p /etc/sddm.conf.d
    fi


    if [ ! -f "${SDDM_ICON_PATH}/${USER}" ] && [ -f "${cloneDir}/.icon" ]; then
        sudo cp "${cloneDir}/.icon" "${SDDM_ICON_PATH}/${USER}"
        print_log -g "[DISPLAYMANAGER] " -b " :: " "avatar set for ${USER}..."
    fi

else
    print_log -y "[DISPLAYMANAGER] " -b " :: " "sddm is not installed..."
fi

# dolphin
if pkg_installed dolphin && pkg_installed xdg-utils; then
    print_log -c "[FILEMANAGER]" -info "Info" -g "detected :: " "dolphin"
    xdg-mime default org.kde.dolphin.desktop inode/directory
    print_log -g "[FILEMANAGER] " -b " :: " -b "setting $(xdg-mime query default "inode/directory") as default file explorer..."

else
    print_log -y "[FILEMANAGER] " -b " :: " "dolphin is not installed..."
    printt_log -y "[FILEMANAGER] " -b " :: " "Setting $(xdg-mime query default "inode/directory") as default file explorer..."
fi

# shell
"${scrDir}/restore_shl.sh"

# flatpak
if ! pkg_installed flatpak; then
    print_log -r "[FLATPAK] " -b "list :: " "flatpak application"
    awk -F '#' '$1 != "" {print "["++count"]", $1}' "${lstDir}/flatpak.lst"
    prompt_timer 60 "Install these flatpaks? [Y/n]"
    fpkopt=${PROMPT_INPUT,,}

    if [ "${fpkopt}" = "y" ]; then
        print_log -g "[FLATPAK] " -b "install :: " "flatpaks"
        "${scrDir}/extra/install_fpk.sh"
    else
        print_log -y "[FLATPAK] " -b "skip :: " "flatpak installation"
    fi

else
    print_log -y "[FLATPAK] " -info "Info" -y "[skip]" -b " :: " "flatpak is already installed"
fi

# vim plugins

print_log -y "[vim] " -info "Info" -b "[plugins]" -b " :: " "installing vim plugins"
vim -c 'PluginInstall' -c 'qa!'

# install sddm and astronaut theme
"${scrDir}/sddm_theme.sh"
