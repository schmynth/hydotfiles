#!/bin/bash

# read control file and initialize variables

scrDir="$(dirname "$(realpath "$0")")"
# shellcheck disable=SC1091
source "${scrDir}/globalcontrol.sh"
# shellcheck disable=SC2154
dockDir="${confDir}/nwg-dock-hyprland"
in_file="${dockDir}/theme/style.css"
out_file="${dockDir}/style.css"
log_file="${dockDir}/log"
src_file="${confDir}/hypr/themes/theme.conf"

export border_radius="10px"
export border_width="2px"
margin_bottom=4
icon_size=32
position="bottom"

# generate style.css
envsubst <"$in_file" >"$out_file"

# kill dock if running
pid="$(ps -C nwg-dock-hyprland | sed '1d')"
if [[ -n $pid ]]; then
	kill -SIGKILL $pid
fi

# override rounded corners
hypr_border=$(awk -F '=' '{if($1~" rounding ") print $2}' "$src_file" | sed 's/ //g')
hypr_border=${hypr_border:-$WAYBAR_BORDER_RADIUS}
if [ "$hypr_border" == "0" ] || [ -z "$hypr_border" ]; then
    sed -i "/border-radius: /c\    border-radius: 0px;" "$out_file"
fi
regenerate
nohup nwg-dock-hyprland -r -x -i $icon_size -mb $margin_bottom -p $position &

