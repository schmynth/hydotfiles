-- ░▒▒▒░░░▓▓ ___________
-- ░░▒▒▒░░░░░▓▓ //___________/
-- ░░▒▒▒░░░░░▓▓ _ _ _ _ _____
-- ░░▒▒░░░░░▓▓▓▓▓▓ | | | | | | | __/
-- ░▒▒░░░░▓▓ ▓▓ | |_| | |_/ /| |___
-- ░▒▒░░▓▓ ▓▓ \__ |____/ |____/
-- ░▒▓▓ ▓▓ //____/
-- // █░█ █▄█ █▀▄ █▀▀
-- // █▀█ ░█░ █▄▀ ██▄

-- Modified by schmynth from HyDE
-- See https://wiki.hyprland.org/configuring/keywords/ for more
-- Example binds: https://wiki.hyprland.org/configuring/binds/ for more

-- Grouping of binds for easier management
-- $d=[Group Name|Subgroup Name1|Subgroup Name2|...]
-- '$d' is a variable that is used to group binds together (or use another variable)
-- This is only for organization purposes and is not a defined hyprland variable
-- What we did here is to modify the Description of the binds to include the group name
-- The $d will be parsed as a separate key to be use for a GUI or something pretty
-- [Main|Subgroup1|Subgroup2|...]
-- Main - The main groupname
-- Subgroup1.. - The subgroup names can be use to avoid repeating the same description

-- // Variables
-- Default if commented out
-- local mainMod = "Super" -- super / meta / windows key
-- Assign apps
-- local TERMINAL = "kitty"
-- local EDITOR = "code"
-- local EXPLORER = "dolphin"
--
require("variables")

local BROWSER = "flatpak run com.brave.Browser"
local wm = "Window Management"
local d = wm

-- // █░░ ▄▀█ █▀█ █▀█ █▀▀ █░█ █▀
-- // █▄▄ █▀█ █▀▀ █▄█ █▄▄ █▀█ ▄█

-- bindd = SUPER, SUPER_L, overview:toggle
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = d .. "|close focused window" })
hl.bind("SUPER + Delete", hl.dsp.exec_cmd("hyprctl exit"), { description = d .. "|kill hyprland session" })
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }), { description = d .. "|toggle float" })
-- hl.bind("SUPER + G", hl.dsp.togglegroup(), { description = d .. "|toggle group" })
hl.bind(
    "SUPER + F",
    hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
    { description = d .. "|toggle fullscreen" }
)
hl.bind("SUPER + SHIFT + P", hl.dsp.window.pin(), { description = d .. "|toggle pin on focused window" })
hl.bind(
    "ALT + RCTRL",
    hl.dsp.exec_cmd("killall waybar || (env reload_flag=1 " .. scrPath .. "/wbarconfgen.sh)"),
    { description = d .. "|toggle waybar and reload config" }
)
-- hl.bind("ALT + RCTRL", hl.dsp.exec_cmd("killall waybar || waybar"), { description = d .. "|toggle waybar" })

d = wm .. "|Group Navigation"
-- hl.bind("SUPER + CTRL + H", hl.dsp.group.change_active({ direction = "b" }), { description = d .. "|change active group backwards" })
-- hl.bind("SUPER + CTRL + L", hl.dsp.group.change_active({ direction = "f" }), { description = d .. "|change active group forwards" })

d = wm .. "|Change focus"
hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }), { description = d .. "|focus left" })
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }), { description = d .. "|focus right" })
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }), { description = d .. "|focus up" })
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }), { description = d .. "|focus down" })
-- hl.bind("ALT + Tab", hl.dsp.focus({ direction = "d" }), { description = d .. "|focus" })

d = wm .. "|Resize Active Window"
-- Resize windows
hl.bind(
    "SUPER + SHIFT + Right",
    hl.dsp.layout("resizeactive 30 0"),
    { repeating = true, description = d .. "|resize window right" }
)
hl.bind(
    "SUPER + SHIFT + Left",
    hl.dsp.layout("resizeactive -30 0"),
    { repeating = true, description = d .. "|resize window left" }
)
hl.bind(
    "SUPER + SHIFT + Up",
    hl.dsp.layout("resizeactive 0 -30"),
    { repeating = true, description = d .. "|resize window up" }
)
hl.bind(
    "SUPER + SHIFT + Down",
    hl.dsp.layout("resizeactive 0 30"),
    { repeating = true, description = d .. "|resize window down" }
)

-- Move active window around current workspace with mainMod + Shift + Control [←→↑↓]
d = wm .. "|Move active window across workspace"
local moveactivewindow =
'grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive'
hl.bind(
    "SUPER + SHIFT + CTRL + Left",
    hl.dsp.exec_cmd(moveactivewindow .. " -30 0 || hyprctl dispatch movewindow l"),
    { repeating = true, description = d .. "|Move activewindow to the left" }
)
hl.bind(
    "SUPER + SHIFT + CTRL + Right",
    hl.dsp.exec_cmd(moveactivewindow .. " 30 0 || hyprctl dispatch movewindow r"),
    { repeating = true, description = d .. "|Move activewindow to the right" }
)
hl.bind(
    "SUPER + SHIFT + CTRL + Up",
    hl.dsp.exec_cmd(moveactivewindow .. " 0 -30 || hyprctl dispatch movewindow u"),
    { repeating = true, description = d .. "|Move activewindow up" }
)
hl.bind(
    "SUPER + SHIFT + CTRL + Down",
    hl.dsp.exec_cmd(moveactivewindow .. " 0 30 || hyprctl dispatch movewindow d"),
    { repeating = true, description = d .. "|Move activewindow down" }
)

-- Move/Resize focused window
d = wm .. "|Move & Resize with mouse"
hl.bind("SUPER + mouse:272", hl.dsp.window.move(), { mouse = true, description = d .. "|hold to move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = d .. "|hold to resize window" })
-- hl.bind("SUPER + Z", hl.dsp.window.move(), { mouse = true, description = d .. "|hold to move window" })
-- hl.bind("SUPER + X", hl.dsp.window.resize(), { mouse = true, description = d .. "|hold to resize window" })

-- Toggle focused window split
d = wm
hl.bind("SUPER + U", hl.dsp.layout("togglesplit"), { description = d .. "|toggle split" })

-- // █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█ █▀▀ █▀█
-- // █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█ █▄▄ █▄█

local l = "Launcher"
d = l .. "|Apps"
hl.bind("SUPER + T", hl.dsp.exec_cmd(TERMINAL), { description = d .. "|terminal emulator" })
hl.bind("SUPER + E", hl.dsp.exec_cmd(EXPLORER), { description = d .. "|file explorer" })
hl.bind("SUPER + C", hl.dsp.exec_cmd(EDITOR), { description = d .. "|text editor" })
hl.bind("SUPER + B", hl.dsp.exec_cmd(BROWSER), { description = d .. "|web browser" })
hl.bind("SUPER + G", hl.dsp.exec_cmd(scrPath .. "/gamelauncher.sh"), { description = d .. "|game launcher" })
hl.bind("SUPER + M", hl.dsp.exec_cmd("thunderbird"), { description = d .. "|mail client" })
hl.bind(
    "CTRL + SHIFT + Escape",
    hl.dsp.exec_cmd(scrPath .. "/sysmonlaunch.sh"),
    { description = d .. "|system monitor" }
)

d = l .. "|Rofi menus"
local rofi_launch = scrPath .. "/rofilaunch.sh"
-- muss noch geändert werden:
-- hl.bind("SUPER + P", hl.dsp.exec_cmd("rofi -show rofi-power-menu -show-icons"), { description = d .. "|rofi power mode" })
hl.bind(
    "SUPER + P",
    hl.dsp.exec_cmd("pkill -x rofi || " .. rofi_launch .. " p"),
    { description = d .. "|rofi power mode" }
)
-- hl.bind("SUPER + Space", hl.dsp.exec_cmd("pkill -x rofi || " .. rofi_launch .. " d"), { description = d .. "|application finder" })
hl.bind(
    "SUPER + Space",
    hl.dsp.exec_cmd("pkill -x rofi || " .. rofi_launch .. " c"),
    { description = d .. "|launcher" }
)
hl.bind(
    "SUPER + Tab",
    hl.dsp.exec_cmd("pkill -x rofi || " .. rofi_launch .. " w"),
    { description = d .. "|window switcher" }
)
hl.bind(
    "SUPER + SHIFT + E",
    hl.dsp.exec_cmd("pkill -x rofi || " .. rofi_launch .. " f"),
    { description = d .. "|file finder" }
)
hl.bind(
    "SUPER + F1",
    hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/keybinds_hint.sh c"),
    { description = d .. "|keybindings hint" }
)
hl.bind(
    "SUPER + comma",
    hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/emoji-picker.sh"),
    { description = d .. "|emoji picker" }
)
hl.bind(
    "SUPER + period",
    hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/glyph-picker.sh"),
    { description = d .. "|glyph picker" }
)
hl.bind(
    "SUPER + SHIFT + V",
    hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh -c"),
    { description = d .. "|clipboard" }
)
hl.bind(
    "SUPER + SHIFT + ALT + V",
    hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh"),
    { description = d .. "|clipboard manager" }
)
hl.bind(
    "SUPER + SHIFT + A",
    hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofiselect.sh"),
    { description = d .. "|select rofi launcher" }
)

-- // █░█ ▄▀█ █▀█ █▀▄ █░█ ▄▀█ █▀█ █▀▀
-- // █▀█ █▀█ █▀▄ █▄▀ █▄█ █░█ █▀▄ █▀▀

local hc = "Hardware Controls"
d = hc .. "|Audio"
-- hl.bind("", "XF86AudioMute", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"), { locked = true, description = d .. "|toggle mute output" })
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"),
    { locked = true, description = d .. "|toggle mute output" }
)
-- hl.bind("", "XF86AudioLowerVolume", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"), { repeating = true, description = d .. "|decrease volume" })
-- hl.bind("", "XF86AudioRaiseVolume", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"), { repeating = true, description = d .. "|increase volume" })
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -i m"),
    { locked = true, description = d .. "|un/mute microphone" }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"),
    { locked = true, repeating = true, description = d .. "|decrease volume" }
)
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"),
    { locked = true, repeating = true, description = d .. "|increase volume" }
)

d = hc .. "|Media"
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = d .. "|play media" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = d .. "|pause media" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = d .. "|next media" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = d .. "|previous media" })

d = hc .. "|Brightness"
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("ddcutil setvcp 10 + 10"),
    { repeating = true, description = d .. "|increase brightness" }
)
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("ddcutil setvcp 10 - 10"),
    { repeating = true, description = d .. "|decrease brightness" }
)
hl.bind(
    "SUPER + Escape",
    hl.dsp.exec_cmd("hyprctl dispatch dpms toggle"),
    { description = d .. "|toggle screen on/off" }
)

-- // █░░ ▀█▀ █▀▀ █░░ █ ▀█▀ █ █▀▀ █▀
-- // █▄▄ ░█░ █▀▀ █░░ █ ░█░ █ █▀▀ ▄█

local ut = ""
