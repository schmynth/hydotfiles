#!/bin/bash

# read control file and initialize variables

# define path variables
scrDir="$(dirname "$(realpath "$0")")"
# shellcheck disable=SC1091
source "${scrDir}/globalcontrol.sh"
# shellcheck disable=SC1091
dockDir="${confDir}/nwg-dock-hyprland"
in_file="${dockDir}/theme/style.css"
out_file="${dockDir}/style.css"

# define dock style related variables
export border_radius="10px"
export border_width="2px"

margin_bottom=4
icon_size=32
position="bottom"

envsubst <"$in_file" >"$out_file"
pid="$(ps -C nwg-look-hyprland | sed '1d')"
if [[ -n $pid ]]; then
		kill -SIGKILL $pid
fi

regenerate
nohup nwg-dock-hyprland -r -x -i $icon_size -mb $margin_bottom -p $position &

