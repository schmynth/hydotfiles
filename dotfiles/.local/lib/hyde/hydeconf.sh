#!/bin/bash

scrDir="$(dirname "$(realpath "$0")")"
# shellcheck disable=SC1091
source "${scrDir}/globalcontrol.sh"

echo "schmynth HyDE config tool"
echo "What would you like to do?"

FILE=$(zenity --file-selection)

