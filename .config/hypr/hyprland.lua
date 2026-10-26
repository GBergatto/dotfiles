------------------
---- MONITORS ----
------------------
hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@60",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080",
  position = "0x-1080",
  scale = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------
local terminal = "ghostty"
local fileManager = "thunar"
local browser = "MOZ_ENABLE_WAYLAND=0 librewolf"
local menu = "wofi --show drun"

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function () 
  hl.exec_cmd("waybar & hyprpaper")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("cliphist wipe")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
   general = {
      gaps_in  = 2,
      gaps_out = 2,
      border_size = 2,

      col = {
         active_border   = { colors = {"rgba(FCFCFCff)", "rgba(ABABABff)"}, angle = 45 },
         inactive_border = "rgba(222222ff)",
      },

      -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false,

      -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
      allow_tearing = false,

      layout = "dwindle",
   },

   decoration = {
      rounding = 0,
      active_opacity = 1.0,
      inactive_opacity = 1.0,
      shadow = { enabled = false, },
      blur = { enabled = false, },
   },

   animations = {
      enabled = true,
   },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })


-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
   dwindle = {
      preserve_split = true, -- You probably want this
   },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
   master = {
      new_status = "master",
   },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
   scrolling = {
      fullscreen_on_one_column = true,
   },
})

----------------
----  MISC  ----
----------------
hl.config({
   misc = {
      force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
      disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background.
      on_focus_under_fullscreen = 1, -- New window replaces fullscreen
   },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout  = "it",
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:escape", "shift:both_capslock",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
        },

        tablet = {
            output = "current",
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Applications / actions
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W",      hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + S",      hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + SHIFT + R",
    hl.dsp.exec_cmd("pkill -x waybar; waybar"))

-- Move focus (vim keys)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Drag windows
hl.bind(mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true })

-- Resize active window
hl.bind(mainMod .. " + CTRL + H",
    hl.dsp.window.resize({ x = -60, y = 0 }))
hl.bind(mainMod .. " + CTRL + L",
    hl.dsp.window.resize({ x = 60, y = 0 }))
hl.bind(mainMod .. " + CTRL + K",
    hl.dsp.window.resize({ x = 0, y = -60 }))
hl.bind(mainMod .. " + CTRL + J",
    hl.dsp.window.resize({ x = 0, y = 60 }))

-- Resize by dragging
hl.bind(mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true })

-- Fullscreen
hl.bind(mainMod .. " + F",
    hl.dsp.window.fullscreen({ mode = 1 }))

hl.bind(mainMod .. " + SHIFT + F",
    hl.dsp.window.fullscreen({ mode = 0 }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10

    hl.bind(mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i }))

    hl.bind(mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({
            workspace = i,
            silent = true,
        }))
end

-- Move current workspace to monitor
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.workspace.move({monitor = 0}))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.workspace.move({monitor = 1}))

-- Previous workspace
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && " ..
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+"),
    { locked = true, repeating = true })

hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"),
    { locked = true, repeating = true })

hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })

hl.bind("XF86AudioMicMute",
    hl.dsp.exec_cmd(
        "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl s 10%+"),
    { locked = true, repeating = true })

hl.bind("XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl s 10%-"),
    { locked = true, repeating = true })

hl.bind("XF86KbdBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl --device='asus::kbd_backlight' set +1"),
    { locked = true, repeating = true })

hl.bind("XF86KbdBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl --device='asus::kbd_backlight' set 1-"),
    { locked = true, repeating = true })

-- Media controls
hl.bind("XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"),
    { locked = true })

hl.bind("XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true })

hl.bind("XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true })

hl.bind("XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

------------------
-- Workspaces
------------------

hl.workspace_rule({
    workspace  = 1,
    monitor    = "HDMI-A-1",
    persistent = false,
})

hl.workspace_rule({
    workspace  = 2,
    monitor    = "eDP-1",
    persistent = false,
})

hl.workspace_rule({
    workspace  = 3,
    monitor    = "eDP-1",
    persistent = false,
})

hl.workspace_rule({
    workspace  = 4,
    monitor    = "HDMI-A-1",
    persistent = false,
})

hl.workspace_rule({
    workspace  = 5,
    monitor    = "eDP-1",
    persistent = false,
})

hl.workspace_rule({
    workspace  = 6,
    monitor    = "eDP-1",
    persistent = false,
})

hl.workspace_rule({
    workspace  = 7,
    monitor    = "eDP-1",
    persistent = false,
})

------------------
-- Window rules
------------------

local workspaceRules = {
    [1] = {
        "^(Brave-browser)$",
        "^(Tor Browser)$",
        "^(librewolf)$",
    },

    [2] = {
        "^(Alacritty)$",
        "^(thunar)$",
        "^(localsend)$",
        "^(com.mitchellh.ghostty)$",
    },

    [3] = {
        "^(md.obsidian.Obsidian)$",
    },

    [4] = {
        "^(mpv)$",
        "^(Zotero)$",
        "^(Readest)$",
        "^(org.kde.okular)$",
        "^(sioyek)$",
        "^(readest)$",
    },

    [5] = {
        "^(MATLAB R202.*)$",
        "^(org.qlandkarte.qmapshack)$",
        "^(org.freecad.FreeCAD)$",
        "^(kicad)$",
        "^(virt-manager)$",
        "^(com.github.xournalpp.xournalpp)$",
        "^(calibre-gui)$",
        "^(gtkwave)$",
        "^(gimp)$",
        "^(org.inkscape.Inkscape)$",
    },

    [6] = {
        "^(anki)$",
        "^(KeePassXC)$",
    },

    [7] = {
        "^(org.mozilla.Thunderbird)$",
        "^(Morgen)$",
        "^(todoist)$",
        "^(org.gnome.Calendar)$",
        "^(org.telegram.desktop)$",
    },
}

for workspace, classes in pairs(workspaceRules) do
    for _, class in ipairs(classes) do
        hl.window_rule({
            match = {
                class = class,
            },

            workspace = workspace,
        })
    end
end

-- Floating windows
hl.window_rule({ match = { class = "^(Matplotlib)$" }, float = true, })
hl.window_rule({ match = { class = "^(feh)$" }, float = true, })
hl.window_rule({ match = { class = "^(thunderbird)$", title = "^(Edit Item)?$" }, float = true, })
hl.window_rule({ match = { class = "^(thunderbird)$", title = "^(Write:).*$" }, float = true, })

-- Ignore maximize requests from apps.
hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
