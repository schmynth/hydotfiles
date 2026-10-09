-- ## █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
-- ## █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█

local mainMod = "SUPER"

-- Adjust these to match your setup.
local terminal = "kitty"
local editor = "code"
-- local fileManager = "dolphin"
local fileManager = "nautilus"
local browser = "flatpak run com.brave.Browser"

-- This was $scrPath in the old config.
-- Change it if your scripts are elsewhere.
local scrPath = os.getenv("scrPath") or os.getenv("SCRIPTS_PATH") or (os.getenv("HOME") .. "/.config/hypr/scripts")

local rofiLaunch = scrPath .. "/rofilaunch.sh"

-- Helpers ---------------------------------------------------------------

local function exec(command)
    return hl.dsp.exec_cmd(command)
end

local function dispatch(command)
    return exec("hyprctl dispatch " .. command)
end

local function bind(key, action, description, options)
    options = options or {}
    options.description = description
    hl.bind(key, action, options)
end

local function d(key, action, description)
    bind(key, action, description)
end

local function mouseBind(key, action, description)
    bind(key, action, description, { mouse = true })
end

-- Window management -----------------------------------------------------

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + Q", hl.dsp.window.close(), "Window Management: close focused window")
hl.bind(mainMod .. " + DELETE", dispatch("exit"), "Window Management: kill Hyprland session")
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(), "Window Management: toggle fullscreen")
hl.bind(mainMod .. " + SHIFT + P", dispatch("pin"), "Window Management: toggle pin on focused window")

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- The original bind used Alt_R + Control_R without a normal key.
-- This preserves that combination as closely as Lua allows.

-- Focus movement ---------------------------------------------------------

--#/# bind = SUPER + ←/↑/→/↓,, -- Focus in direction
for i = 1, 4 do
    local arrowkey = { "Left", "Right", "Up", "Down" }
    local vimnavkeys = { "H", "L", "K", "J" }
    local focusdir = { "l", "r", "u", "d" }
    hl.bind(
        "SUPER + " .. vimnavkeys[i],
        hl.dsp.focus({ direction = focusdir[i] }),
        { description = "Window: Focus " .. arrowkey[i] }
    )
end
for i = 1, 2 do
    local arrowkey = { "BracketLeft", "BracketRight" }
    local focusdir = { "l", "r" }
    hl.bind("SUPER + " .. arrowkey[i], hl.dsp.focus({ direction = focusdir[i] }))
end
--#/# bind = SUPER + SHIFT, ←/↑/→/↓,, -- Move in direction
for i = 1, 4 do
    local arrowkey = { "Left", "Right", "Up", "Down" }
    local vimnavkeys = { "H", "L", "K", "J" }
    local focusdir = { "l", "r", "u", "d" }
    hl.bind(
        "SUPER + SHIFT + " .. vimnavkeys[i],
        hl.dsp.window.move({ direction = focusdir[i] }),
        { description = "Window: Move " .. arrowkey[i] }
    )
end

-- Resize active window --------------------------------------------------

-- hl.bind(mainMod .. " + SHIFT + RIGHT", dispatch("resizeactive 30 0"), "Window Management / Resize: resize right")
-- hl.bind(mainMod .. " + SHIFT + LEFT", dispatch("resizeactive -30 0"), "Window Management / Resize: resize left")
-- hl.bind(mainMod .. " + SHIFT + UP", dispatch("resizeactive 0 -30"), "Window Management / Resize: resize up")
-- hl.bind(mainMod .. " + SHIFT + DOWN", dispatch("resizeactive 0 30"), "Window Management / Resize: resize down")

-- Move active window ----------------------------------------------------

local moveActiveWindow = [[
if grep -q "true" <<< "$(hyprctl activewindow -j | jq -r .floating)"; then
    hyprctl dispatch moveactive "$@"
else
    hyprctl dispatch movewindow "$@"
fi
]]

hl.bind(
    mainMod .. " + SHIFT + CTRL + LEFT",
    exec(moveActiveWindow .. " l"),
    "Window Management / Move window: move left"
)
hl.bind(
    mainMod .. " + SHIFT + CTRL + RIGHT",
    exec(moveActiveWindow .. " r"),
    "Window Management / Move window: move right"
)
hl.bind(mainMod .. " + SHIFT + CTRL + UP", exec(moveActiveWindow .. " u"), "Window Management / Move window: move up")
hl.bind(
    mainMod .. " + SHIFT + CTRL + DOWN",
    exec(moveActiveWindow .. " d"),
    "Window Management / Move window: move down"
)

mouseBind(mainMod .. " + mouse:272", hl.dsp.window.drag(), "Window Management / Mouse: hold to move window")

mouseBind(mainMod .. " + mouse:273", hl.dsp.window.resize(), "Window Management / Mouse: hold to resize window")

hl.bind(mainMod .. " + U", dispatch("layoutmsg togglesplit"), "Window Management: toggle focused window split")

-- Applications ----------------------------------------------------------

hl.bind(mainMod .. " + T", exec(terminal), "Launcher / Apps: terminal emulator")
hl.bind(mainMod .. " + E", exec(fileManager), "Launcher / Apps: file explorer")
hl.bind(mainMod .. " + C", exec(editor), "Launcher / Apps: text editor")
hl.bind(mainMod .. " + B", exec(browser), "Launcher / Apps: web browser")
hl.bind(mainMod .. " + G", exec(scrPath .. "/gamelauncher.sh"), "Launcher / Apps: game launcher")
hl.bind(mainMod .. " + M", exec("thunderbird"), "Launcher / Apps: mail client")
hl.bind("CTRL + SHIFT + escape", exec(scrPath .. "/sysmonlaunch.sh"), "Launcher / Apps: system monitor")

-- Rofi menus ------------------------------------------------------------

local function rofi(command)
    return exec("pkill -x rofi || " .. command)
end

-- d(mainMod .. " + P", rofi(rofiLaunch .. " p"), "Launcher / Rofi: power menu")
-- d(mainMod .. " + SPACE", rofi(rofiLaunch .. " c"), "Launcher / Rofi: launcher")
d(mainMod .. " + TAB", rofi(rofiLaunch .. " w"), "Launcher / Rofi: window switcher")
d(mainMod .. " + SHIFT + E", rofi(rofiLaunch .. " f"), "Launcher / Rofi: file finder")
d(mainMod .. " + F1", rofi(scrPath .. "/keybinds_hint.sh c"), "Launcher / Rofi: keybindings hint")
-- d(mainMod .. " + COMMA", rofi(scrPath .. "/emoji-picker.sh"), "Launcher / Rofi: emoji picker")
d(mainMod .. " + PERIOD", rofi(scrPath .. "/glyph-picker.sh"), "Launcher / Rofi: glyph picker")
d(mainMod .. " + SHIFT + V", rofi(scrPath .. "/cliphist.sh -c"), "Launcher / Rofi: clipboard")
d(mainMod .. " + SHIFT + ALT + V", rofi(scrPath .. "/cliphist.sh"), "Launcher / Rofi: clipboard manager")
d(mainMod .. " + SHIFT + A", rofi(scrPath .. "/rofiselect.sh"), "Launcher / Rofi: select launcher")

-- Audio -----------------------------------------------------------------

-- Media -----------------------------------------------------------------

d("XF86AudioPlay", exec("playerctl play-pause"), "Hardware Controls / Media: play or pause")
d("XF86AudioPause", exec("playerctl play-pause"), "Hardware Controls / Media: pause")
d("XF86AudioNext", exec("playerctl next"), "Hardware Controls / Media: next")
d("XF86AudioPrev", exec("playerctl previous"), "Hardware Controls / Media: previous")

-- Brightness and display ------------------------------------------------

hl.bind("XF86MonBrightnessUp", exec("ddcutil setvcp 10 + 10"), "Hardware Controls / Brightness: increase brightness")
hl.bind("XF86MonBrightnessDown", exec("ddcutil setvcp 10 - 10"), "Hardware Controls / Brightness: decrease brightness")
hl.bind(
    mainMod .. " + escape",
    exec("hyprctl dispatch dpms toggle"),
    "Hardware Controls / Display: toggle screen on or off"
)

-- Screen capture --------------------------------------------------------

hl.bind(mainMod .. " + SHIFT + P", exec("hyprpicker -an"), "Utilities / Screen Capture: color picker")
hl.bind("PRINT", exec("screenshot.sh s"), "Utilities / Screen Capture: screenshot region")
hl.bind(mainMod .. " + PRINT", exec("screenshot.sh m"), "Utilities / Screen Capture: screenshot window")

-- Workspaces ------------------------------------------------------------

-- Special workspace / scratchpad ---------------------------------------

d(mainMod .. " + SHIFT + S", dispatch("movetoworkspace special"), "Workspaces / Special workspace: move to scratchpad")

d(
    mainMod .. " + ALT + S",
    dispatch("movetoworkspacesilent special"),
    "Workspaces / Special workspace: move silently to scratchpad"
)

d(mainMod .. " + S", dispatch("togglespecialworkspace"), "Workspaces / Special workspace: toggle scratchpad")

-- NOCTALIA

local ipc = "noctalia msg "

-- Core binds
hl.bind(mainMod .. "+Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. "+W", hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"))
hl.bind(mainMod .. "+P", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))
hl.bind(mainMod .. "+C", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. "+comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

-- Noctalia Settings
hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})
