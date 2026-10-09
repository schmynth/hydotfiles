-- █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
-- ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█

-- ===== COMMON POPUPS =====

hl.window_rule({
    match = {
        title =
        "^(Choose Files|Save As|Confirm to replace files|File Operation Progress|Open|Authentication Required|Add Folder to Workspace|File Upload.*|Choose wallpaper.*|Library.*|.*dialog.*)$",
    },
    float = true,
    center = true,
})

local opacity = "1 0.8 1"

-- ===== WORKSPACE ASSIGNMENTS BY CLASS =====

hl.window_rule({ match = { class = "^(Vivaldi-flatpak)$" }, workspace = 4 })
hl.window_rule({ match = { class = "^(brave-browser)$" }, workspace = 1 })
hl.window_rule({ match = { class = "^(kitty)$" }, workspace = 2 })
hl.window_rule({ match = { class = "^(org.kde.dolphin)$" }, workspace = 3 })
hl.window_rule({ match = { class = "^(darktable)$" }, workspace = 4 })
hl.window_rule({ match = { class = "^(feishin)$" }, workspace = 5 })
hl.window_rule({ match = { class = "^(net.lutris.Lutris)$" }, workspace = 7 })
hl.window_rule({ match = { class = "^([Ss]team)$" }, workspace = 7 })
hl.window_rule({ match = { title = "^(Steam)$" }, workspace = 7 })
hl.window_rule({ match = { class = "^(net.shadps4.qtlauncher)$" }, workspace = 7 })

-- ===== WORKSPACE ASSIGNMENTS BY INITIAL TITLE =====

hl.window_rule({ match = { initial_title = "^(.*Schaltplaneditor)$" }, workspace = 4 })
hl.window_rule({ match = { initial_title = "^(.*Leiterplatteneditor)$" }, workspace = 5 })

-- ===== OPACITY RULES =====

-- Browsers
hl.window_rule({ match = { class = "^(firefox)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(brave-browser)$" }, opacity = opacity })

-- Code editors
hl.window_rule({ match = { class = "^(code-oss)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^([Cc]ode)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(code-url-handler)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(code-insiders-url-handler)$" }, opacity = opacity })

-- Terminal & file managers
hl.window_rule({ match = { class = "^(kitty)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(org.kde.dolphin)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(org.kde.ark)$" }, opacity = opacity })

-- Theme tools
hl.window_rule({ match = { class = "^(nwg-look)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(qt5ct)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(qt6ct)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(kvantummanager)$" }, opacity = opacity })

-- Audio & network
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(nm-applet)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, opacity = opacity })

-- Authentication & portals
hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(polkit-gnome-authentication-agent-1)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(org.freedesktop.impl.portal.desktop.gtk)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^(org.freedesktop.impl.portal.desktop.hyprland)$" }, opacity = opacity })

-- Gaming & media
-- hl.window_rule({ match = { class = "^([Ss]team)$" }, opacity = opacity })
-- hl.window_rule({ match = { class = "^(steamwebhelper)$" }, opacity = opacity })
hl.window_rule({ match = { class = "^([Ss]potify)$" }, opacity = opacity })
hl.window_rule({ match = { initial_title = "^(Spotify Free)$" }, opacity = opacity })
hl.window_rule({ match = { initial_title = "^(Spotify Premium)$" }, opacity = opacity })

-- GTK & misc applications
hl.window_rule({ match = { class = "^(com.github.rafostar.Clapper)$" }, opacity = opacity }) -- Clapper-Gtk
hl.window_rule({
    match = { class = "^(com.github.tchx84.Flatseal)$" },
    opacity = opacity,
}) -- Flatseal-Gtk
hl.window_rule({
    match = { class = "^(hu.kramo.Cartridges)$" },
    opacity = opacity,
}) -- Cartridges-Gtk
hl.window_rule({
    match = { class = "^(com.obsproject.Studio)$" },
    opacity = opacity,
})                                                                             -- Obs-Qt
hl.window_rule({ match = { class = "^(gnome-boxes)$" }, opacity = opacity })   -- Boxes-Gtk
hl.window_rule({ match = { class = "^(vesktop)$" }, opacity = opacity })       -- Vesktop
hl.window_rule({ match = { class = "^(discord)$" }, opacity = opacity })       -- Discord-Electron
hl.window_rule({ match = { class = "^(WebCord)$" }, opacity = opacity })       -- WebCord-Electron
hl.window_rule({ match = { class = "^(ArmCord)$" }, opacity = opacity })       -- ArmCord-Electron
hl.window_rule({ match = { class = "^(app.drey.Warp)$" }, opacity = opacity }) -- Warp-Gtk
hl.window_rule({
    match = { class = "^(net.davidotek.pupgui2)$" },
    opacity = opacity,
})                                                                      -- ProtonUp-Qt
hl.window_rule({ match = { class = "^(yad)$" }, opacity = opacity })    -- Protontricks-Gtk
hl.window_rule({ match = { class = "^(Signal)$" }, opacity = opacity }) -- Signal-Gtk
hl.window_rule({
    match = { class = "^(io.github.alainm23.planify)$" },
    opacity = opacity,
}) -- planify-Gtk
hl.window_rule({
    match = { class = "^(io.gitlab.theevilskeleton.Upscaler)$" },
    opacity = opacity,
}) -- Upscaler-Gtk
hl.window_rule({
    match = { class = "^(com.github.unrud.VideoDownloader)$" },
    opacity = opacity,
}) -- VideoDownloader-Gtk
hl.window_rule({
    match = { class = "^(io.gitlab.adhami3310.Impression)$" },
    opacity = opacity,
}) -- Impression-Gtk
hl.window_rule({
    match = { class = "^(io.missioncenter.MissionCenter)$" },
    opacity = opacity,
}) -- MissionCenter-Gtk
hl.window_rule({
    match = { class = "^(io.github.flattool.Warehouse)$" },
    opacity = opacity,
}) -- Warehouse-Gtk

-- ===== FLOAT RULES =====

-- Dolphin dialogs
hl.window_rule({ match = { class = "^(org.kde.dolphin)$", title = "^(Progress Dialog — Dolphin)$" }, float = true })
hl.window_rule({ match = { class = "^(org.kde.dolphin)$", title = "^(Copying — Dolphin)$" }, float = true })

-- Firefox
hl.window_rule({ match = { title = "^(About Mozilla Firefox)$" }, float = true })
hl.window_rule({ match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { class = "^(firefox)$", title = "^(Library)$" }, float = true })

-- KiCad
hl.window_rule({ match = { initial_class = "^(KiCad)$" }, float = true })

-- Terminal utilities
hl.window_rule({ match = { class = "^(kitty)$", title = "^(top)$" }, float = true })
hl.window_rule({ match = { class = "^(kitty)$", title = "^(btop)$" }, float = true })
hl.window_rule({ match = { class = "^(kitty)$", title = "^(htop)$" }, float = true })

-- Media players & utilities
hl.window_rule({ match = { class = "^(vlc)$" }, float = true })
hl.window_rule({ match = { class = "^(kvantummanager)$" }, float = true })
hl.window_rule({ match = { class = "^(qt5ct)$" }, float = true })
hl.window_rule({ match = { class = "^(qt6ct)$" }, float = true })
hl.window_rule({ match = { class = "^(nwg-look)$" }, float = true })
hl.window_rule({ match = { class = "^(org.kde.ark)$" }, float = true })

-- Audio & network
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = "^(nm-applet)$" }, float = true })
hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, float = true })

-- Authentication & dialogs
hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, float = true })
hl.window_rule({ match = { class = "^(show-file-dialog-gtk3)$" }, float = true })
hl.window_rule({ match = { class = "^(Juce Plug-In Host)$" }, float = true })
hl.window_rule({ match = { class = "^()$" }, float = true })

-- Applications (Signal, Clapper, etc)
hl.window_rule({ match = { class = "^(Signal)$" }, float = true }) -- Signal-Gtk
hl.window_rule({ match = { title = "Bitwarden" }, float = true })  -- Bitwarden
