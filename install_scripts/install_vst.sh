#!/usr/bin/env bash

# Script to install hyprland plugin(s)
# by schmynth
# plugins must be in seperate list file in $scrDir/lists as referenced below
# list must contain line of format $plugin_name $url/path
# TODO: implement installing from .tar.xz file on disk (i.e. path instead of
# url)

scrDir=$(dirname "$(realpath "$0")")
lstDir="${scrDir}/lists"
# shellcheck disable=SC1091
if ! source "${scrDir}/global_fn.sh"; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

log_section="audio plugins"

install_tarball() {
  plugin_name=$1
  url=$2
  plugin_dir="${lstDir}/${plugin_name}"
  mkdir $plugin_dir
  print_log -info "Info" -b "[install] :: " -y "[tar]" " $1"
  wget $url -O "${plugin_name}.tar.xz"
  tar -xf "${plugin_name}.tar.xz" -C "${plugin_dir}"
  rm "${plugin_name}.tar.xz"
  cd "${plugin_dir}"
  $(find . -type f -iname "install.sh")
  cd ..
  rm -rf "${plugin_dir}"
}

parse_line() {    
  plugin_name=$(echo ${line} | cut -f1 -d' ')
  url=$(echo ${line} | cut -f2 -d' ')
  plugin=("$plugin_name" "$url")
  echo ${plugin[@]}
}

install_from_github_test() {
  print_log -info "Info" -b "[install] :: " -y "[GitHub]" " $1"
}

install_tarball_test() {
  print_log -info "Info" -b "[install] :: " -y "[tar.xz]" " $1"
}



print_log -warn "Audio Plugins" -y " This script only installs plugins from install_scripts/lists/plugins.lst"
print_log -warn "Audio Plugins" -y " For plugins present in the repositories, add them to install_scripts/lists/packages.list"
print_log -info "Info" "install VST plugins that are not in the repositories"

while read line; do
  case "$line" in 
    \#*) # ignore comments
      continue
	    ;;
    *github*)
	    plugin=(`parse_line`)
      install_from_github_test ${plugin[0]} ${plugin[1]}
	    ;;
    *.tar.*)
	    plugin=(`parse_line`)
      install_tarball_test ${plugin[0]} ${plugin[1]}
      ;;
  esac
done < "${lstDir}/plugins.lst"


