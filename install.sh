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


                                                      
  _ _ / _     _//  /   _/_   ' _  _/_ //   _ _ _ ' _/ 
_) ( /)//)(//)//) /)(/(/(-  /_) /)/(/((  _) ( / //)/  
          /         /                           /     

EOF

#--------------------------------#
# import variables and functions #
#--------------------------------#

cloneDir="$(dirname "$(realpath "$0")")"
lstDir="${scrDir}/lists"

# shellcheck disable=SC1091
if ! source "${cloneDir}/instal_scripts/global_fn.sh"; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

scrDir="${cloneDir}/install_scripts"

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

while getopts "idrstmnhf" flag; do
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
    print_log -r "[nvidia] " -b "Ignored :: " "skipping Nvidia actions"
    ;;
  h)
    # shellcheck disable=SC2034
    export flg_Shell=0
    print_log -r "[shell] " -b "Reevaluate :: " "shell options"
    ;;
  t) flg_DryRun=1 ;;
  m) flg_ThemeInstall=0 ;;
  f) flg_Rebooted=0 ;;
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
    print_log -n "[test-run] " -b "enabled :: " "Testing without executing"
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

    #----------------#
    # get user prefs #
    #----------------#
    echo ""
    if ! chk_list "aurhlpr" "${aurList[@]}"; then
        print_log -c "\nAUR Helpers :: "
        aurList+=("yay-bin" "paru-bin") # Add this here instead of in global_fn.sh
        for i in "${!aurList[@]}"; do
            print_log -sec "$((i + 1))" " ${aurList[$i]} "
        done

        prompt_timer 120 "Enter option number [default: yay-bin] | q to quit "

        case "${PROMPT_INPUT}" in
        1) export getAur="yay" ;;
        2) export getAur="paru" ;;
        3) export getAur="yay-bin" ;;
        4) export getAur="paru-bin" ;;
        q)
            print_log -sec "AUR" -crit "Quit" "Exiting..."
            exit 1
            ;;
        *)
            print_log -sec "AUR" -warn "Defaulting to yay-bin"
            print_log -sec "AUR" -stat "default" "yay-bin"
            export getAur="yay-bin"
            ;;
        esac
        if [[ -z "$getAur" ]]; then
            print_log -sec "AUR" -crit "No AUR helper found..." "Log file at ${cacheDir}/logs/${HYDE_LOG}"
            exit 1
        fi
    fi

    if ! chk_list "myShell" "${shlList[@]}"; then
        print_log -c "Shell :: "
        for i in "${!shlList[@]}"; do
            print_log -sec "$((i + 1))" " ${shlList[$i]} "
        done
        prompt_timer 120 "Enter option number [default: zsh] | q to quit "

        case "${PROMPT_INPUT}" in
        1) export myShell="zsh" ;;
        2) export myShell="fish" ;;
        q)
            print_log -sec "shell" -crit "Quit" "Exiting..."
            exit 1
            ;;
        *)
            print_log -sec "shell" -warn "Defaulting to zsh"
            export myShell="zsh"
            ;;
        esac
        print_log -sec "shell" -stat "Added as shell" "${myShell}"
        echo "${myShell}" >>"${lstDir}/install_pkg.lst"

        if [[ -z "$myShell" ]]; then
            print_log -sec "shell" -crit "No shell found..." "Log file at ${cacheDir}/logs/${HYDE_LOG}"
            exit 1
        else
            print_log -sec "shell" -stat "detected :: " "${myShell}"
        fi
    fi

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
    print_log -g "[generate] " "cache ::" "Wallpapers..."
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
            print_log -y "[skip] " -b "active " "Service ${serviceChk}"
        else
            print_log -y "start" "Service ${serviceChk}"
            if [ $flg_DryRun -ne 1 ]; then
                sudo systemctl enable "${serviceChk}.service"
                # sudo systemctl start "${serviceChk}.service"
            fi
        fi

    done <"${lstDir}/system_ctl.lst"
fi

cat <<"EOF"

               
    /  _ '   _ 
 /)((/(///)_)  
/    _/        
               

EOF

print_log -stat "Log" "Please make sure to run ${scrDir}/install_plugins.sh after rebooting if you wish to install hyprland plugins."

print_log -stat "Log" "setting sddm resolution"
"${scrDir}/sddm_resolution.sh"

cat <<"EOF"

 _          
(_ '  ' _ / 
/ //)/_) /)

EOF

if [ $flg_Install -eq 1 ]; then
    print_log -stat "\nInstallation" "completed"
fi
print_log -stat "Log" "View logs at ${cacheDir}/logs/${HYDE_LOG}"
if [ $flg_Install -eq 1 ] ||
    [ $flg_Restore -eq 1 ] ||
    [ $flg_Service -eq 1 ]; then
    print_log -stat "HyDE" "It is not recommended to use newly installed or upgraded HyDE without rebooting the system. Do you want to reboot the system? (y/N)"
    read -r answer

    if [[ "$answer" == [Yy] ]]; then
        echo "Rebooting system"
        systemctl reboot
    else
        echo "The system will not reboot"
    fi
fi

