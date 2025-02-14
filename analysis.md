# My fork of HyDE

This is my fork of the HyDE dotfiles for hyprland. In this file I try to analyze what HyDE does and if it is safe to use. Also this file serves as a guide to customize HyDE to my/your liking.

# Config Guide

## Wallpapers

Wallpapers are stored in .config/hyde/themes/[theme name]/wallpapers on a per theme basis. Drop your wallpapers where you think fit.

## Themes

The themes are sourced from project HyDE github repo.

### Cursor

Change the cursor in ~/.local/share/hyde/hyprland.conf under CURSOR
You should combine a XCURSOR and HYPRCURSOR theme by taking the xcursor theme and copying the hyprcursor/ folder from the HYPRCURSOR theme into it, so that the theme folder has the following structure:
    themename/
        cursors/ # xcursor
        hyprcursors/ # hyprcursor
        cursor.theme
        index.theme

## Hyprland

General override config files are located in ~/.config/hypr/ as usual. These override the boilerplate files in ~/.local/share/hyde/ 
More info in ~/.config/hypr/hyprland.conf

### Hyprlock

Make your own hyprlock layout and put it in

    ~/.config/hypr/hyprlock/

## zsh

Put your zsh aliases and keybinds in ~/.zshrc


# Questions

[X] where are preconfigured zsh keybinds stored? -> they are part of oh-my-zsh
[X] where does oh-my-zsh come from? -> it is installed by Scripts/restore_shl.sh
[X] what is hyde-shell? $HOME/.local/bin/hyde-shell
[ ] how do i install different cursor theme? -> set in restore_fnt.lst
[ ] where do the themes and wallpapers come from? -> they come from HyDE/themes repo as in Scripts/themepatcher.lst
[ ] how is stuff from Source/arcs (.tar.gz) installed?
[X] how do the dotfiles get installed? By Scripts/restore_cfg.sh
    - The config files are listed in restore_cfg.psv (restore_cfg.lst is deprecated and can be deleted seems like)
[ ] how to set user avatar for sddm?



Config files:

.local/share/hyde/
    config.toml # general hyde config
    hyprland.conf # env variables

# Hyde file structure:

Scripts/
    extra/
        custom_flat.lst # OK, contains flatpak packages to install, updated
        restore_app.sh # OK, updated, removed firefox extension installation
        install_fpk.sh # OK
        restore_lnk.sh
    global_fn.sh # OK, utility functions
    install_aur.sh # OK, installs selected AUR helper
    install_pkg.sh # OK, installs pacman packages
    install_pre.sh # OK
    install_pst.sh # installiert sddm, runs restore_shl.sh, sddm vlt ungewollt ??????????
    install.sh # OK
    pkg_core.lst # OK, packages to install from arch core repo
    pkg_extra.lst # OK, packages to install from extra repo or AUR
    restore_shl.sh # OK
    systemctl.lst # OK
    themepatcher.lst # contains links to themes
    
Configs
    .local/
        state/
            dolphinstaterc # OK
        bin/
            hyde-shell      # script, checkt, ob HyDE installiert ist. Ruft interactive_shell.
                            # hyde_reload, zoom und wallbash auf, je nach Argument.
        lib/
            hyde/ [$scrPath]
                amdgpu.py   # OK
                animations.sh # OK
                batterynotify.sh # OK
                brightnesscontrol.sh # OK
                cliphist.sh	# OK      
                cpuinfo.sh # OK  
                dontkillsteam.sh # OK
                emoji-picker.sh # OK
                fastfetch.sh # OK
                font.sh	# Resolves, downloads and installs fonts
                gamelauncher.sh       
                globalcontrol.sh # OK, contains env variables for scripts
                glyph-picker.sh # OK
                gnome-terminal # OK	
                gpuinfo.sh # OK
                hyde-launch.sh # OK, IG, launches mime type apps	
                hyprlock.sh # OK	
                hyprsunset.sh # OK	
                hypr.unbind.sh # OK
                keyboardswitch.sh # OK
                keybinds.hint.py # OK	
                keybinds_hint.sh # OK	
                lockscreen.sh # OK, runs hyprlock
                logoutlaunch.sh # runs wlogout, should be replaced by rofi power 
                mediaplayer.py	   
                notifications.py   
                parse.json.py	   
                polkitkdeauth.sh # where is /usr/lib/polkit-gnome/ ?
                quickapps.sh	   
                resetxdgportal.sh # OK
                rofilaunch.sh # OK, launches rofi in different modes, added rofi-power-menu
                rofiselect.sh # seems to select style
                sensorsinfo.py
                swwwallbash.sh    
                sysmonlaunch.sh   
                swwwallcache.sh   
                swwwallkon.sh # 
                swwwallpaper.sh # OK, only runs wallpaper.sh
                swwwallselect.sh  
                systemupdate.sh   
                testrunner.sh     
                themeselect.sh    
                themeswitch.sh
                volumecontrol.sh # OK
                wallbash.hypr.sh
                wallbash.print.colors.sh
                wallbash.qt.sh
                wallbash.sh
                wallbashtoggle.sh
                wallpaper.sh # OK, i guess
                wbarconfgen.sh # OK, generates waybar config
                wbarstylegen.sh
                weather.py
        share/
            dolphin/ # OK
            hyde/
                config.toml # OK, config file for HyDE
                dunst.conf # OK, config file for dunst
                hyde.conf # OK, override hyde config file
                emoji.db # OK
                glyph.db # OK
                hyprland.conf # boilerplate hyprland config file
                hyprlock.conf
                keybindings.conf # OK, renamed to keybindings.conf.bak
                rofi/
                    assets/ # OK, only pngs
                    themes/ # OK, only themes
            icons/
            kio/ 
                servicemenus/
                    hydewallpaper.desktop # runs swwwwallkon.sh, sets wallpaper from context menu
            kxmlgui5/ # OK
        state/
    .config/
        hypr/
            animations/     # OK, Override config files for hyprland.conf
            themes/ # OK
                colors.conf # OK, wallbash color palette
                theme.conf # OK, theme info, auto updated
                wallbash.conf # OK, auto-generated by HyDe
            animations.conf # OK, references .config/hypr/animations/theme.conf
            hyde.conf # OK, reference file for configuration, no code, configure in .local/share/hyde 
            hypridle.conf # calls lockscreen.sh, sources .config/hypridle/*
            hyprlock/ # OK
                theme.conf # OK, takes wallbash variables 
            hyprlock.conf # sources ~/.local/share/hyde/hyprlock.conf and 
                          # ~/.config/hypr/hyprlock/theme.conf
            keybindings.conf # OK, edited to my liking
            monitors.conf # OK, monitor config file, default empty
            userprefs.conf # OK, hyprland preferences for user, default empty, added KB layouts
            windowrules.conf # OK, only windowrules
        Code/ # OK
        dunst/ # OK    
        fastfetch/ # OK
        gtk-3.0/ # OK
        hyde/
            wallbash/
                always/ # OK, only dcol templates
                scripts/
                    code.sh # runs wallbash with vsix wallbash addon in VSCode
                    discord.sh # OK, evaluates .css files
                    spotify.sh # OK, I GUESS, updates spicetify theme
                theme/
                    code.dcol # OK, only VSCode theme dcol template
            config.toml # OK, empty config override file
        kitty/ # OK
        Kvantum/ # OK
        lsd/ # OK, only colors, icons, config
        MangoHud/ # OK, mangohud config file
        menus/ # OK, menu for dolphin
        nwg-look/ # OK
        qt5ct/ # OK
        qt6ct/ # OK
        rofi/ # OK
        swaylock/ # OK, aber vlt unnötig
        VSCodium/ # OK, aber vlt unnötig
        waybar/
            modules/ # OK, wenn alle scripts ok sind!!!!!
            config.ctl # OK, templates for layouts, edit this for changes
                        # important: spaces before and after () needed!
            config.jsonc # OK, generated, do not edit
            style.css # OK
            theme.css # OK
        wlogout/ # OK
        xsettingsd/ # OK
        baloofilerc # OK
        dolphinrc # OK
        electron-flags # OK
        kdeglobals # OK
        libinput-gestures # OK
        spotify-flags # OK
        vscodium-flags
    .gtkrc-2.0 # OK
    .hyde.zshrc # OK, zsh config, f.e. pokego
    .p10k.zsh
    .zshenv
    .zshrc # OK, use for zsh override config
