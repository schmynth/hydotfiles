#!/usr/bin/env bash
# shellcheck disable=SC2154
#|---/ /+--------------------------+---/ /|#
#|--/ /-| Main installation script |--/ /-|#
#|-/ /--| schmynth                 |-/ /--|#
#|/ /---+--------------------------+/ /---|#

cat <<"EOF"

        .
       / \    
      /^  \      
     /  _  \    
    /  | | ~\  
   /.-'   '-.\ 


                                                      
  _ _ / _     _//  /   _/_   '  __/_ //   _ _ _ ' _/ 
_) ( /)//)(//)//) /)(/(/(-  //)_)/(/((  _) ( / //)/  
          /         /                          /     

EOF

# ASCII font is "Italic"
# http://patorjk.com/software/taag/#p=display&f=Italic&t=finish%0A%0A

#--------------------------------#
# import variables and functions #
#--------------------------------#

cloneDir="$(dirname "$(realpath "$0")")"

# shellcheck disable=SC1091
if ! source "${cloneDir}/install_scripts/global_fn.sh"; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

scrDir="${cloneDir}/install_scripts"
lstDir="${scrDir}/lists"

export cloneDir

#------------------#
# evaluate options #
#------------------#
flg_Install=0
flg_Restore=0
flg_Service=0
flg_DryRun=0
flg_Shell=0
flg_Nvidia=1
flg_ThemeInstall=1
flg_Rebooted=0
flg_VirtualMachine=0

while getopts "idrstmnhvf" flag; do
  case $flag in
  i) flg_Install=1 ;;
  d)
    flg_Install=1
    export use_default="--noconfirm"
    ;;
  r) flg_Restore=1 ;;
  s) flg_Service=1 ;;
  n)
    # shellcheck disable=SC2034
    export flg_Nvidia=0
    print_log -info "Info" -r "[nvidia] " -b "Ignored :: " "skipping Nvidia actions"
    ;;
  h)
    # shellcheck disable=SC2034
    export flg_Shell=0
    print_log -r "[shell] " -b "Reevaluate :: " "shell options"
    ;;
  t) flg_DryRun=1 ;;
  m) flg_ThemeInstall=0 ;;
  v) flg_VirtualMachine=1 ;;
  f) flg_Rebooted=1 ;;
  *)
    cat <<EOF
Usage: $0 [options]
  i : [i]nstall hyprland without configs
  d : install hyprland [d]efaults without configs --noconfirm
  r : [r]estore config files
  s : enable system [s]ervices
  n : ignore/[n]o [n]vidia actions
  h : re-evaluate S[h]ell
  m : no the[m]e reinstallations
  t : [t]est run without executing (-irst to dry run all)
  v : this is a virtual machine
  f : [f]inish installation after reboot
EOF
  exit 1
  ;;
  esac
done

# Only export that are used outside this script
HYDE_LOG="$(date +'%y%m%d_%Hh%Mm%Ss')"
export flg_DryRun flg_Nvidia flg_Shell flg_Install flg_ThemeInstall HYDE_LOG

if [ "${flg_DryRun}" -eq 1 ]; then
    print_log -sec "GENERAL" -info "Info" -n "[test-run] " -b "enabled :: " "Testing without executing"
elif [ $OPTIND -eq 1 ]; then
    flg_Install=1
    flg_Restore=1
    flg_Service=1
fi

#--------------------#
# pre-install script #
#--------------------#
if [ ${flg_Install} -eq 1 ] && [ ${flg_Restore} -eq 1 ] && [ ${flg_Rebooted} -eq 0 ]; then
    cat <<"EOF"

                      
    _ _   '   __/_ // 
 /)/ (-  //)_) /(/((  
/                     


EOF

# schmynth:
# pacman gets candy, Color and multilib repo
# removed bootloader and chaotic aur related code

    "${scrDir}/install_pre.sh"
fi

#------------#
# installing #
#------------#
if [ ${flg_Install} -eq 1 ] && [ ${flg_Rebooted} -eq 0 ]; then
    cat <<"EOF"

                    
 '   __/_ //__/'    
//)_) /(/(((///()/) 
                    
EOF

    #----------------------#
    # prepare package list #
    #----------------------#
    shift $((OPTIND - 1))
    custom_pkg=$1
    cp "${lstDir}/packages.lst" "${lstDir}/install_pkg.lst"
    trap 'mv "${lstDir}/install_pkg.lst" "${cacheDir}/logs/${HYDE_LOG}/install_pkg.lst"' EXIT

    if [ -f "${custom_pkg}" ] && [ -n "${custom_pkg}" ]; then
        cat "${custom_pkg}" >>"${lstDir}/install_pkg.lst"
    fi
    echo -e "\n#user packages" >>"${lstDir}/install_pkg.lst" # Add a marker for user packages
    #--------------------------------#
    # add nvidia drivers to the list #
    #--------------------------------#
    if nvidia_detect; then
        if [ ${flg_Nvidia} -eq 1 ]; then
            cat /usr/lib/modules/*/pkgbase | while read -r kernel; do
                echo "${kernel}-headers" >>"${lstDir}/install_pkg.lst"
            done
            nvidia_detect --drivers >>"${lstDir}/install_pkg.lst"
        else
            print_log -warn "Nvidia" " :: " "Nvidia GPU detected but ignored..."
        fi
    fi
    nvidia_detect --verbose
    
    if [ ${flg_VirtualMachine} -eq 1 ]; then
      print_log -info "Info" -r "[VM] " -b "Virtual Machine :: " "installing packages for Virtual Machines"
      sudo pacman -Syu --needed spice spice-gtk spice-protocol spice-vdagent gvfs-dnssd
    fi

    #-----------------#
    # removed choices #
    #-----------------#

    echo ""
    export getAur="yay"
    export myShell="zsh"

    if ! grep -q "^#user packages" "${lstDir}/install_pkg.lst"; then
        print_log -sec "pkg" -crit "No user packages found..." "Log file at ${cacheDir}/logs/${HYDE_LOG}/install.sh"
        exit 1
    fi

    #--------------------------------#
    # install packages from the list #
    #--------------------------------#
    [ ${flg_DryRun} -eq 1 ] && [ ${flg_Rebooted} -eq 0 ]|| "${scrDir}/install_pkg.sh" "${lstDir}/install_pkg.lst"
fi

#---------------------------#
# restore my custom configs #
#---------------------------#
if [ ${flg_Restore} -eq 1 ] && [ ${flg_Rebooted} -eq 0 ]; then
    cat <<"EOF"


       _                
 _    (_ '_   _ __/'    
( ()/)/ /(/(// (///()/) 
        _/              


EOF

    if [ "${flg_DryRun}" -ne 1 ] && [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ] && [ ${flg_Rebooted} -eq 0 ]; then
        hyprctl keyword misc:disable_autoreload 1 -q
    fi

    "${scrDir}/restore_fnt.sh"
    "${scrDir}/restore_cfg.sh"
    "${scrDir}/restore_thm.sh"
    print_log -sec "config" -g "[generate] " "cache ::" "Wallpapers..."
    if [ "${flg_DryRun}" -ne 1 ]; then
        "$HOME/.local/lib/hyde/swwwallcache.sh" -t ""
        "$HOME/.local/lib/hyde/themeswitch.sh" -q || true
        echo "[install] reload :: Hyprland"
    fi

fi

#---------------------#
# post-install script #
#---------------------#
if [ ${flg_Install} -eq 1 ] && [ ${flg_Restore} -eq 1 ] && [ ${flg_Rebooted} -eq 0 ]; then
    cat <<"EOF"

                        
       __/  '   __/_ // 
 /)()_) /  //)_) /(/((  
/                       


EOF

    "${scrDir}/install_pst.sh"
fi

#---------------------#
# realtime audio      #
#---------------------#

if [ ${flg_Install} -eq 1 ] && [ ${flg_Restore} -eq 1 ] && [ ${flg_Rebooted} -eq 0 ]; then
  cat <<"EOF"

                                   
 _   _/'      _/'_  '_  __/'     _ 
(/(/(//() ()/)////)/ /_(///()/)_)  
           /                       


EOF
	   "${scrDir}/realtime_audio.sh"
fi

#------------------------#
# enable system services #
#------------------------#
if [ ${flg_Service} -eq 1 ] && [ ${flg_Rebooted} -eq 0 ]; then
    cat <<"EOF"

                  
  _ _ _   '_ _  _ 
_) (-/ \//( (-_)  
                  

EOF

while read -r serviceChk; do

        if [[ $(systemctl list-units --all -t service --full --no-legend "${serviceChk}.service" | sed 's/^\s*//g' | cut -f1 -d' ') == "${serviceChk}.service" ]]; then
            print_log -sec "services" -info "Info" -y "[skip] " -b "active " "Service ${serviceChk}"
        else
            print_log -sec "services" -info "Info" -b "[start] " "Service ${serviceChk}"
            if [ $flg_DryRun -ne 1 ]; then
                sudo systemctl enable "${serviceChk}.service"
                # sudo systemctl start "${serviceChk}.service"
            fi
        fi

    done <"${lstDir}/system_ctl.lst"
fi

if [ ${flg_Rebooted} -eq 1 ]; then

  cat <<"EOF"

               
    /  _ '   _ 
 /)((/(///)_)  
/    _/        
               

EOF

#  print_log -sec "Hyprland" -info "Info" -wt "installing hyprland plugins"
  
#  "${scrDir}/install_plugins.sh"
  
  print_log -sec "sddm" -info "Info" -wt "setting sddm resolution"
  "${scrDir}/sddm_resolution.sh"

  print_log -sec "VS Code" -info "Info" -wt " installing VS Code extensions"
  "${scrDir}/install_code_ext.sh"
fi


# finish

cat <<"EOF"

 _          
(_ '  ' _ / 
/ //)/_) /)

EOF

if [ $flg_Install -eq 1 ]; then
    print_log -sec "GENERAL" -info "Info" "Installation completed"
fi

print_log -sec "GENERAL" -info "Log" "View logs at ${cacheDir}/logs/${HYDE_LOG}"

if [ $flg_Install -eq 1 ] || [ $flg_Restore -eq 1 ] || [ $flg_Service -eq 1 ]; then
    print_log -sec "GENERAL" -info "HyDE" "It is not recommended to use newly installed or upgraded HyDE without rebooting the system. After rebooting, make sure to run the install.sh with the -f flag to finish installation. Do you want to reboot the system? (y/N)"
    read -r answer

    if [[ "$answer" == [Yy] ]]; then
        echo "Rebooting system"
        systemctl reboot
    else
        echo "The system will not reboot"
    fi
fi

