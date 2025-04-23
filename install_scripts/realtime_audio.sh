#!/bin/bash

scrDir="$(dirname "$(realpath "$0")")"
# shellcheck disable=SC1091
if ! source "${scrDir}/global_fn.sh"; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

# find full path of script:
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
tabs 40


get_kernel_parameters () {
		local line6=$(echo | awk 'NR>5 && NR<7' $1)
		local params=$(echo $line6 | cut -d '"' -f2)
		echo $params
}

add_kernel_parameter ()  {
	if [[ ! " ${kernel_parameters_list[*]} " =~ $1 ]]; then
			print_log -sec "GRUB" -info "Info" "${1} kernel parameter not found"
			print_log -sec "GRUB" -info "Info" -b "add ${1} kernel parameter to grub config"
	
sudo -i -u root bash <<EOF
sed -i "6s/.$/ $1\"/" /etc/default/grub
EOF
	
	else
			print_log -sec "GRUB" -info "Info" "kernel parameter ${1} already in place"
	fi
}

update_grub () {
sudo -i -u root bash <<EOF
grub-mkconfig -o /boot/grub/grub.cfg
EOF
}

group_exists () {
		if grep -q $1 /etc/group
		then
			print_log -sec "System" -info "Info" "Group $1 exists"
		else
			print_log -sec "System" -info "Info" -b "Group $1 does not exist. Create group $1"
sudo -i -u root bash <<EOF
groupadd $1
EOF
		fi
}


user_in_realtime_group () {
	if id -nG "$USER" | grep -qw realtime; then
		print_log -sec "System" -info "Info" "User already in realtime group"	
	else
		print_log -sec "System" -info "Info" "User not in realtime group. Add user to it"
sudo -i -u root bash <<EOF
usermod -a -G realtime $USER
EOF
	fi

}

cpupower_user_auth () {
	print_log -sec "System" -warn "sudo" "authorize $USER to run sudo cpupower without password to launch DAW"
	print_log -sec "System" -info "Info" "echo \"$USER ALL=(ALL:ALL) NOPASSWD: /usr/bin/cpupower\" > /etc/sudoers.d/20-cpupower"
	sudo -i -u root bash <<EOF
echo "$USER ALL=(ALL:ALL) NOPASSWD: /usr/bin/cpupower" > /etc/sudoers.d/20-cpupower
EOF
}

add_interrupt_service () {
	sudo cp "${scrDir}/extra/interrupt_freq.service" /etc/systemd/system/
	sudo cp "${scrDir}/extra/interrupt_freq.sh" /usr/bin/
	sudo systemctl enable interrupt_freq.service
}

max_user_watches () {
	print_log -sec "Config" -info "Info" -b "setting max_user_watches.conf to 600000"
	
sudo -i -u root bash << EOF
echo "fs.inotify.max_user_watches = 600000" > /etc/sysctl.d/90-max_user_watches.conf
EOF
}

swappiness () {
	print_log -sec "System" -info "Info" -b "setting swappiness to 10"
	
sudo -i -u root bash << EOF
echo "vm.swappiness = 10" > /etc/sysctl.d/90-swappiness.conf
EOF
}

apply_optimizations () {
	group_exists realtime
	user_in_realtime_group
	print_log -sec "Package" -info "Info" -b "installing realtime-privileges"
	sudo pacman -S realtime-privileges --needed || print_log -sec "Package" -err "installation of realtime-privileges failed."
	
	max_user_watches	
	swappiness
	print_log -sec "Service" -info "Info" -g "setting max-user-freq to 2048 at boot"
	add_interrupt_service	
	cpupower_user_auth
	
	
	kernel_parameters_list=($(get_kernel_parameters /etc/default/grub))
	
	print_log -sec "GRUB" -info "Info" "current kernel parameters:"
	print_log -sec "GRUB" -info "Info" "\e[34m${kernel_parameters_list[*]}"
	add_kernel_parameter "threadirqs"
	print_log -sec "GRUB" -info "Info" -b "update GRUB"
	update_grub
	print_log -sec "System" -info "Info" "Be sure to reboot after applying these optimizations."
}
# apply_optimization end

print_log -sec "General" -info "Info" "This script optimizes the system for realtime audio processing as proposed in the Arch Linux Wiki."
print_log -sec "General" -warn "Distro" "This script is meant for Arch Linux. Do NOT run this on any other distro!"
print_log -sec "General" -warn "System Files" "\e[1;31mTHIS SCRIPT WILL MODIFY SYSTEM FILES AS ROOT! MAKE SURE YOU READ THE SCRIPT BEFORE EXECUTING IT! (install_scripts/realtime_audio.sh)\e[0m"

read -p "Are you sure you want to apply these realtime optimizations? (yY)" -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]
then
		apply_optimizations
else
		print_log -sec "Quit" -info "Info" "Execution of script cancelled by the user"
fi

