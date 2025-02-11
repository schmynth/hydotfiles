dunst: notification daemon

what is hyde-shell? $HOME/.local/bin/hyde-shell


Hyde Structure:

Configs
    .local/
        state/
            hyde/
                dolphinstaterc
        bin/
            hyde-shell      # script, checkt, ob HyDE installiert ist. Ruft interactive_shell.
                            # hyde_reload, zoom und wallbash auf, je nach Argument.
        lib/
            hyde/
                amdgpu.py   # OK
                animations.sh #
                gamemode.sh 
                keyboardswitch.sh
                screenshot.sh
                volumecontrol.sh
                globalcontrol.sh
                lockscreen.sh
                sensorsinfo.py
                wallbash.hypr.sh
                batterynotify.sh      
                glyph-picker.sh	
                logoutlaunch.sh    
                swwwallbash.sh    
                wallbash.print.colors.sh
                brightnesscontrol.sh  
                gnome-terminal	
                mediaplayer.py	   
                swwwallcache.sh   
                wallbash.qt.sh
                gpuinfo.sh	
                notifications.py   
                swwwallkon.sh     
                wallbash.sh
                cliphist.sh	      
                grimblast		
                parse.config.py    
                swwwallpaper.sh   
                wallbashtoggle.sh
                cpuinfo.sh	      
                hyde-launch.sh	
                parse.json.py	   
                swwwallselect.sh  
                wallpaper.sh
                dontkillsteam.sh # OK
                hyprlock.sh	
                polkitkdeauth.sh   
                sysmonlaunch.sh   
                wbarconfgen.sh
                emoji-picker.sh       
                hyprsunset.sh	
                quickapps.sh	   
                systemupdate.sh   
                wbarstylegen.sh
                fastfetch.sh	      
                hypr.unbind.sh	
                resetxdgportal.sh  
                testrunner.sh     
                weather.py
                font.sh	# Resolves, downloads and installs fonts
                keybinds.hint.py	
                rofilaunch.sh	   
                themeselect.sh    
                gamelauncher.sh       
                keybinds_hint.sh	
                rofiselect.sh	   
                themeswitch.sh
        share/
        state/
    .config/
        hypr/
            animations/     # OK, Override config files for hyprland.conf
            animations.conf # OK, references .config/hypr/animations/theme.conf
            hyde.conf # OK, reference file for configuration, no code 
            hypridle.conf # calls lockscreen.sh, sources .config/hypridle/*
            hyprlock/
                theme.conf # OK, takes wallbash variables 
            hyprlock.conf # sources ~/.local/share/hyde/hyprlock.conf and 
                          # ~/.config/hypr/hyprlock/theme.conf
            
            
