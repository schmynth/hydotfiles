#!/bin/bash

scrDir="$(dirname "$(realpath "$0")")"
# shellcheck disable=SC1091
source "${scrDir}/globalcontrol.sh"

# Delete cache not modified for 20 days
print_log -sec "cache" " Deleting cache not modified for 20 days"
find ~/.cache -depth -type f -mtime +20 -delete

#clean Journals
print_log -sec "journal" " cleaning journal"
sudo journalctl --vacuum-time=20d

#Remove all pkg from cache except those installed
print_log -sec "pkg cache" " Removing all pkg from cache except those installed"
sudo pacman -Sc

#Remove ALL pkg from cache
#sudo pacman -Scc

print_log -sec "pkg cache" " removing cache from uninstalled packages"
#remove cache from uninstalled packages
paccache -ruk0

#update mirrorlist
print_log -sec "mirrors" " updating mirrorlist"
sudo reflector --country France,Germany --age 12 --download-timeout 4 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

print_log -sec "pkg orphans" " removing orphans..."
sudo pacman -R $(pacman -Qdtq)

#Clean home cache! ~/.cache
