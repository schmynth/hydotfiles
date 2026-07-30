-- // █░█ █▄█ █▀▄ █▀▀
-- // █▀█ ░█░ █▄▀ ██▄

-- scripttest comment

require("hyprland.variables")

local toolPath = os.getenv("HOME") .. "/.local/lib/tools" -- set tools path

-- Main modifier
local mainMod = "SUPER" -- windows key

-- assign apps
local default = {}
default.QUICKAPPS = ""
default.BROWSER = "hyde-launch.sh --fall firefox web-browser"
default.EDITOR = "hyde-launch.sh --fall code-oss text-editor"
default.EXPLORER = "hyde-launch.sh --fall dolphin file-manager"
default.TERMINAL = "kitty"
default.LOCKSCREEN = "hyprlock"
default.IDLE = "hypridle"

local QUICKAPPS = default.QUICKAPPS
local BROWSER = default.BROWSER
local EDITOR = default.EDITOR
local EXPLORER = default.EXPLORER
local TERMINAL = default.TERMINAL
local LOCKSCREEN = default.LOCKSCREEN
local IDLE = default.IDLE

-- // █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
-- // █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█
-- See https://wiki.hyprland.org/Configuring/Keywords/

local start = {}
start.XDG_PORTAL_RESET = scrPath .. "/resetxdgportal.sh"
start.DBUS_SHARE_PICKER = "dbus-update-activation-environment --systemd --all"                  -- for XDPH
start.SYSTEMD_SHARE_PICKER =
"systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"  -- for XDPH
start.BAR = "waybar"
start.DOCK = scrPath .. "/dockstylegen.sh"
start.NOTIFICATIONS = "dunst"
start.APPTRAY_BLUETOOTH = "blueman-applet"
start.WALLPAPER = scrPath .. "/swwwallpaper.sh"
start.TEXT_CLIPBOARD = "wl-paste --type text --watch cliphist store"
start.IMAGE_CLIPBOARD = "wl-paste --type image --watch cliphist store"
start.BATTERY_NOTIFY = scrPath .. "/batterynotify.sh"
start.NETWORK_MANAGER = "nm-applet --indicator"
start.REMOVABLE_MEDIA = "udiskie --no-automount --smart-tray"
start.AUTH_DIALOGUE = scrPath .. "/polkitkdeauth.sh"
start.IDLE_DAEMON = IDLE

-- // █▀▀ █▄░█ █░█
-- // ██▄ █░▀█ ▀▄▀
-- See https://wiki.hyprland.org/Configuring/Environment-variables/
-- Toolkit Backend Variables - https://wiki.hyprland.org/Configuring/Environment-variables/#toolkit-backend-variables

local env = {}
env.GDK_BACKEND = "wayland,x11,*" -- GTK: Use wayland if available. If not: try x11, then any other GDK backend.
-- env.QT_QPA_PLATFORM = "wayland;xcb" -- Qt: Use wayland if available, fall back to x11 if not.
env.SDL_VIDEODRIVER =
"wayland"                         -- Run SDL2 applications on Wayland. Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
env.CLUTTER_BACKEND =
"wayland"                         -- Clutter package already has wayland enabled, this variable will force Clutter applications to try and use the Wayland backend

-- XDG Specifications - https://wiki.hyprland.org/Configuring/Environment-variables/#xdg-specifications
env.XDG_CURRENT_DESKTOP = "Hyprland"
env.XDG_SESSION_TYPE = "wayland"
env.XDG_SESSION_DESKTOP = "Hyprland"

-- Qt Variables - https://wiki.hyprland.org/Configuring/Environment-variables/#qt-variables
env.QT_AUTO_SCREEN_SCALE_FACTOR =
"1"                                           -- (From the Qt documentation) enables automatic scaling, based on the monitor's pixel density
env.QT_QPA_PLATFORM =
"wayland;xcb"                                 -- Tell Qt applications to use the Wayland backend, and fall back to x11 if Wayland is unavailable
env.QT_WAYLAND_DISABLE_WINDOWDECORATION = "1" -- Disables window decorations on Qt applications
env.QT_QPA_PLATFORMTHEME = "qt6ct"            -- Tells Qt based applications to pick your theme from qt5ct, use with Kvantum.

-- HyDE Environment Variables
env.PATH = ""
env.MOZ_ENABLE_WAYLAND = "1"              -- Enable Wayland for Firefox
env.GDK_SCALE = "1"                       -- Set GDK scale to 1 // For Xwayland on HiDPI
env.ELECTRON_OZONE_PLATFORM_HINT = "auto" -- Set Electron Ozone Platform Hint to auto // For Electron apps on Wayland

-- XDG-DIRS
-- env.XDG_RUNTIME_DIR = os.getenv("XDG_RUNTIME_DIR") or ("/run/user/" .. io.popen("id -u"):read())
-- env.XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
-- >> env.XDG_CACHE_HOME = os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")
-- env.XDG_DATA_HOME = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
env.XDG_RUNTIME_DIR = os.getenv("XDG_RUNTIME_DIR")
env.XDG_CONFIG_HOME = os.getenv("HOME") .. "/.config"
env.XDG_CACHE_HOME = os.getenv("HOME") .. "/.cache"
env.XDG_DATA_HOME = os.getenv("HOME") .. "/.local/share"
env.XDG_STATE_HOME = os.getenv("HOME") .. "/.local/state"

-- // █▀▀ ▀█▀ █▄▀
-- // █▄█ ░█░ █░█

local default_theme = {}
default_theme.GTK_THEME = "Wallbash-Gtk"
default_theme.ICON_THEME = "Tela-circle-dracula"
default_theme.COLOR_SCHEME = "prefer-dark"

local GTK_THEME = default_theme.GTK_THEME
local ICON_THEME = default_theme.ICON_THEME
local COLOR_SCHEME = default_theme.COLOR_SCHEME

-- // █▀▀ █░█ █▀█ █▀ █▀█ █▀█
-- // █▄▄ █▄█ █▀▄ ▄█ █▄█ █▀▄

local default_cursor = {}
default_cursor.CURSOR_THEME = "Bibata-Modern-Ice"
default_cursor.CURSOR_SIZE = "24"

local CURSOR_THEME = default_cursor.CURSOR_THEME
local CURSOR_SIZE = default_cursor.CURSOR_SIZE

-- // █▀▀ █▀█ █▄░█ ▀█▀
-- // █▀░ █▄█ █░▀█ ░█░

local default_fonts = {}
default_fonts.FONT = "Cantarell"
default_fonts.FONT_SIZE = "10"
default_fonts.DOCUMENT_FONT = "Cantarell"
default_fonts.DOCUMENT_FONT_SIZE = "10"
default_fonts.MONOSPACE_FONT = "CaskaydiaCove Nerd Font Mono"
default_fonts.MONOSPACE_FONT_SIZE = "9"
default_fonts.NOTIFICATION_FONT = "Mononoki Nerd Font Mono"
default_fonts.BAR_FONT = "JetBrainsMono Nerd Font"
-- default_fonts.MENU_FONT = "This is not yet set as it looks perfect with the global font"
default_fonts.FONT_ANTIALIASING = "rgba"
default_fonts.FONT_HINTING = "full"

local FONT = default_fonts.FONT
local FONT_SIZE = default_fonts.FONT_SIZE
local DOCUMENT_FONT = default_fonts.DOCUMENT_FONT
local DOCUMENT_FONT_SIZE = default_fonts.DOCUMENT_FONT_SIZE
local MONOSPACE_FONT = default_fonts.MONOSPACE_FONT
local MONOSPACE_FONT_SIZE = default_fonts.MONOSPACE_FONT_SIZE
local NOTIFICATION_FONT = default_fonts.NOTIFICATION_FONT
local BAR_FONT = default_fonts.BAR_FONT
-- local MENU_FONT = default_fonts.MENU_FONT
local FONT_ANTIALIASING = default_fonts.FONT_ANTIALIASING
local FONT_HINTING = default_fonts.FONT_HINTING

-- // █▀ █▀█ █▀▀ █▀▀ █ ▄▀█ █░░
-- // ▄█ █▀▀ ██▄ █▄▄ █ █▀█ █▄▄

local config = {}

config.decoration = {
    dim_special = 0.3,
    active_opacity = 0.90,
    inactive_opacity = 0.75,
    fullscreen_opacity = 1,
    blur = {
        special = true,
    },
}

-- // █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█
-- // █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄
-- See https://wiki.hyprland.org/Configuring/Monitors/

config.monitor = { ",preferred,auto,auto" }

-- // █ █▄░█ █▀█ █░█ ▀█▀
-- // █ █░▀█ █▀▀ █▄█ ░█░
-- See https://wiki.hyprland.org/Configuring/Variables/

config.input = {
    kb_layout = "us",
    follow_mouse = 1,
    touchpad = {
        natural_scroll = false,
    },
    sensitivity = 0,
    force_no_accel = true,
    numlock_by_default = true,
}

-- See https://wiki.hyprland.org/Configuring/Variables/
-- // █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀ █▀
-- // █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░ ▄█
-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/

config.dwindle = {
    -- pseudotile = true,
    preserve_split = true,
}

-- See https://wiki.hyprland.org/Configuring/Master-Layout/

config.master = {
    new_status = "master",
}

-- // █▀▄▀█ █ █▀ █▀▀
-- // █░▀░█ █ ▄█ █▄▄
-- See https://wiki.hyprland.org/Configuring/Variables/

config.misc = {
    vrr = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = 0,
}

config.xwayland = {
    force_zero_scaling = true,
}

-- // ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
-- // █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█
-- See https://wiki.hyprland.org/Configuring/Animations/

config.animations = {
    enabled = true,
    bezier = {
        wind = "0.05, 0.9, 0.1, 1.05",
        winIn = "0.1, 1.1, 0.1, 1.1",
        winOut = "0.3, -0.3, 0, 1",
        liner = "1, 1, 1, 1",
    },
    animation = {
        { "windows",     1, 6,  "wind",   "slide" },
        { "windowsIn",   1, 6,  "winIn",  "slide" },
        { "windowsOut",  1, 5,  "winOut", "slide" },
        { "windowsMove", 1, 5,  "wind",   "slide" },
        { "border",      1, 1,  "liner" },
        { "borderangle", 1, 30, "liner",  "once" },
        { "fade",        1, 10, "default" },
        { "workspaces",  1, 5,  "wind" },
    },
}

config.general = {
    snap = {
        -- snapping for floating windows
        enabled = true,
    },
}

-- // █▀ █▀█ █░█ █▀█ █▀▀ █▀▀
-- // ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄
-- hyprlang noerror true
-- source = env.XDG_STATE_HOME .. "/hyde/hyprgui.conf" -- GUI specific config. Used to not break the low level configs. this will be available downstream
-- source = env.XDG_CONFIG_HOME .. "/hypr/themes/colors.conf" -- Hyde wallbash colors

-- Source groupbar in here
config.group_groupbar = {
    col_inactive = "rgba($wallbash_pry3ee)",
    col_active = "rgba($wallbash_pry1ee)",
    col_locked_active = "rgba($wallbash_pry2ee)",
    col_locked_inactive = "rgba($wallbash_pry4ee)",
}

-- source = env.XDG_CONFIG_HOME .. "/hypr/themes/theme.conf" -- theme specific settings
-- source = env.XDG_CONFIG_HOME .. "/hypr/themes/wallbash.conf" -- Theme specific settings after Sanitize and handle fallbacks
-- source = env.XDG_CONFIG_HOME .. "/hypr/nvidia.conf" -- Nvidia specific settings
-- source = env.XDG_CONFIG_HOME .. "/hypr/animations.conf" -- source animations variables
-- hyprlang noerror false
-- source = env.XDG_CONFIG_HOME .. "/hypr/hyde.conf"
-- hyprlang noerror true
-- source = ANIMATION_PATH -- source animations configuration
-- hyprlang noerror false

-- !Below this is an immutable part of the configuration file, and should not be modified by the user.
-- ?By Hyprland convention env and startup files are sourced at the end of the main configuration file
-- ?To ensure that the user's settings are not overridden by the default settings
-- ?This will let us launch after all envs and variables are
