#!/bin/bash

# Delete cache not modified for 20 days
echo "Deleting cache not modified for 20 days"
find ~/.cache -depth -type f -mtime +20 -delete

#clean Journals
echo "cleaning journal"
sudo journalctl --vacuum-time=20d

#Remove all pkg from cache except those installed
echo "Removing all pkg from cache except those installed"
sudo pacman -Sc

#Remove ALL pkg from cache
#sudo pacman -Scc

echo "removing cache from uninstalled packages"
#remove cache from uninstalled packages
paccache -ruk0

#update mirrorlist
echo "updating mirrorlist"
reflector --country France,Germany --age 12 --download-timeout 4 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "removing orphans..."
sudo pacman -R $(pacman -Qdtq)

#Clean home cache! ~/.cache
