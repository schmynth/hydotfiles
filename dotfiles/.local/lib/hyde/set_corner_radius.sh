#!/bin/sh

confFile="$HOME/.config/btop/btop.conf"
if [[ $1 == "--zero-radius" ]]; then
  sed -i '/rounded_corners/c\rounded_corners = False' ${confFile}
else
  sed -i '/rounded_corners/c\rounded_corners = True' ${confFile}
fi
  

echo $confFile
