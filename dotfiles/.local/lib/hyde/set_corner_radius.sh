#!/bin/sh

# set btop corners:

btopConfFile="$HOME/.config/btop/btop.conf"
if [[ $1 == "--zero-radius" ]]; then
  sed -i '/rounded_corners/c\rounded_corners = False' ${btopConfFile}
else
  sed -i '/rounded_corners/c\rounded_corners = True' ${btopConfFile}
fi
  
# set superfile corners:

spfConfFile="$HOME/.config/superfile/config.toml"

string="
# Border style
border_top = '─'
border_bottom = '─'
border_left = '│'
border_right = '│'
border_top_left = '╭'
border_top_right = '╮'
border_bottom_left = '╰'
border_bottom_right = '╯'
border_middle_left = '├'
border_middle_right = '┤'
"
