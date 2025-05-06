#!/usr/bin/env bash

# Script to install hyprland plugin(s)
# by schmynth
#

scrDir=$(dirname "$(realpath "$0")")
lstDir="${scrDir}/lists"
# shellcheck disable=SC1091
if ! source "${scrDir}/global_fn.sh"; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

log_section="audio plugins"


print_log -info "Info" -b "[install] :: " "VST plugins"

while read line; do
	plugin_name=$(echo ${line} | cut -f1 -d' ')
	url=$(echo ${line} | cut -f2 -d' ')
	plugin_dir="${lstDir}/${plugin_name}"
	mkdir $plugin_dir
	print_log -info "Info" -b "[install] :: " "$plugin_name"
	wget $url -O "${plugin_name}.tar.xz"
	tar -xf "${plugin_name}.tar.xz" -C "${plugin_dir}"
	rm "${plugin_name}.tar.xz"
	cd "${plugin_dir}"
	$(find . -type f -iname "install.sh")
	cd ..
	rm -rf "${plugin_dir}"
done < "${lstDir}/plugins.lst"


