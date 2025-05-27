#!/bin/bash

set_powersave() {
	sudo cpupower frequency-set -r -g powersave
	notify-send "set cpu governor to powersave"
}

set_performance() {
	sudo cpupower frequency-set -r -g performance
	notify-send "set cpu governor to performance"
}

set_performance 
cd /opt/resolve/bin
RUSTICL_ENABLE=radeonsi resolve
trap "set_powersave" EXIT
