#!/bin/sh

# set btop corners

btopConfFile="$HOME/.config/btop/btop.conf"
if [[ $1 == "--zero-radius" ]]; then
  sed -i '/rounded_corners/c\rounded_corners = False' ${btopConfFile}
else
  sed -i '/rounded_corners/c\rounded_corners = True' ${btopConfFile}
fi
  
# set superfile corners

superfileConfFile=$HOME/.config/superfile/config.toml

declare -A rounded_corners=(
  [border_top]="─"
  [border_bottom]="─"
  [border_left]="│"
  [border_right]="│"
  [border_top_left]="╭"
  [border_top_right]="╮"
  [border_bottom_left]="╰"
  [border_bottom_right]="╯"
  [border_middle_left]="├"
  [border_middle_right]="┤"
)

declare -A edged_corners=(
  [border_top]="━"
  [border_bottom]="━"
  [border_left]="┃"
  [border_right]="┃"
  [border_top_left]="┏"
  [border_top_right]="┓"
  [border_bottom_left]="┗"
  [border_bottom_right]="┛"
  [border_middle_left]="┣"
  [border_middle_right]="┫"
)

declare -A corners

# copy the chosen corners into corners dict

if [[ $1 == "--zero-radius" ]]; then
  for key in "${!edged_corners[@]}"; do
    corners["$key"]="${edged_corners[$key]}"
  done
else
  for key in "${!rounded_corners[@]}"; do
    corners["$key"]="${rounded_corners[$key]}"
  done
fi

# replace in config file
for key in "${!corners[@]}"; do
  value="${corners[$key]}"
  new_line="${key} = '${value}'"
  # echo $new_line
  # sed "/$key/\c${new_line}" ${superfileConfFile}
  sed -i "s|^${key} *= *.*|${new_line}|" "$superfileConfFile"
done
