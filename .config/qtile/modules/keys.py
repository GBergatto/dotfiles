from libqtile.config import Key
from libqtile.lazy import lazy

from modules.common import mod, terminal, browser
from modules.lazy_functions import (
    move_focus_to_next_screen,
    move_focus_to_prev_screen,
    move_window_to_next_screen,
    move_window_to_prev_screen,
)

keys = [

    Key([mod], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),

    Key([mod], "comma", lazy.to_screen(0), desc='Keyboard focus to monitor 1'),
    Key([mod], "period", lazy.to_screen(1), desc='Keyboard focus to monitor 2'),

    Key([mod], "Return", lazy.spawn(terminal), lazy.group["2"].toscreen()),
    Key([mod], "w", lazy.spawn(browser)),

    Key([mod], "d", lazy.spawn("rofi -show drun")),
    #Key([mod], "d", lazy.spawn("dmenu_run -i -nb '#191919' -nf '#0c5685' -sb '#0c5685' -sf '#191919' -fn 'Inconsolata:bold:pixelsize=16'")),
    Key([mod], "c", lazy.spawn("clipmenu -i")),
    #Key([mod], "c", lazy.spawn("clipmenu -i -fn 'Inconsolata:pixelsize=14' -nb '#002b36' -nf '#839496' -sb '#073642' -sf '#93a1a1'")),
    Key([mod], "x", lazy.spawn("dm-logout")),
    Key([mod], "s", lazy.spawn("flameshot gui")),
    Key([mod], "p", lazy.spawn("pavucontrol"), desc="Launch Pavucontrol"),
    Key([mod, "shift"], "h", lazy.spawn(f"{terminal} -e htop"), lazy.group["2"].toscreen()),
    Key([mod], "Delete", lazy.spawn("xkill")),
    # doesn't work
    Key([mod, "shift"], "k", lazy.spawn("setxkbap -option shift:both_capslock -option caps:escape")),
    Key([mod, "shift"], "Return", lazy.spawn("thunar")),

    # Jump between last 2 groups
    Key([mod], "Tab", lazy.screen.toggle_group()),

    Key([mod], "f", lazy.window.toggle_fullscreen()),

    # QTILE LAYOUT KEYS
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),
    # CHANGE FOCUS
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

    # RESIZE UP, DOWN, LEFT, RIGHT
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key(
        [mod, "control"],
        "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key(
        [mod, "control"],
        "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key(
        [mod, "control"],
        "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    Key(
        [mod, "control"],
        "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    # FLIP LAYOUT FOR MONADTALL/MONADWIDE
    #Key([mod, "shift"], "f", lazy.layout.flip()),

    # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    Key([mod, "shift"], "f", lazy.window.bring_to_front()),
]

spawn_apps = [
    # ===== Core =====
    #Key(
    #    [mod],
    #    "s",
    #    lazy.spawn('rofi -show-icons -icon-theme "Papirus" -show drun -font "Fira Code 12"'),
    #    desc="Spawn rofi",
    #),
    # ===== Browser =====
    Key(
        [mod],
        "semicolon",
        lazy.spawn("sh /home/spyros/.local/bin/dmenuunicode"),
        desc="Spawn emoji picker",
    ),
    #Key(["mod1"], "l", lazy.spawn("light-locker-command -l"), desc="Lock Screen"),
    # ===== Media Control =====
    # Volume
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn('sh -c "pactl set-sink-mute 0 false ; pactl set-sink-volume 0 +10%"'),
        #lazy.spawn("amixer -c 1 set Master 10%+ unmute"),
        #lazy.spawn("pulsemixer --change-volume +5 --unmute"),
        desc="Raise volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn('sh -c "pactl set-sink-mute 0 false ; pactl set-sink-volume 0 -10%"'),
        #lazy.spawn("amixer -c 1 set Master 10%-"),
        #lazy.spawn("pulsemixer --change-volume -5 --unmute"),
        desc="Lower volume",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn('pactl set-sink-mute 0 toggle'),
        #lazy.spawn("amixer -D pulse set Master 1+ toggle"),
        desc="Toggle mute"
    ),
    Key([], "XF86AudioNext", lazy.spawn("playerctl --all-players next"), desc="Next track"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl --all-players previous"), desc="Prev Track"),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl --all-players play-pause"), desc="Play/Pause"),
    # ===== Brightness =====
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl --class='backlight' set 10%-"),
        desc="Increase screen brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl --class='backlight' set +10%"),
        desc="Increase screen brightness",
    ),
    Key(
        [],
        "XF86KbdBrightnessUp",
        lazy.spawn("brightnessctl --device='asus::kbd_backlight' set +1"),
        desc="Increase keyboard backlight",
    ),
    Key(
        [],
        "XF86KbdBrightnessDown",
        lazy.spawn("brightnessctl --device='asus::kbd_backlight' set 1-"),
        desc="Decrease keyboard backlight",
    ),
    # ===== Screenshot =====
    #Key([], "Print", lazy.spawn("flameshot gui"), desc="Print-screen area"),
    #Key(
    #    ["control"],
    #    "Print",
    #    lazy.spawn("flameshot full -c -p /home/spyros/Pictures/Screenshots"),
    #    desc="Print-screen full-screen",
    #),
]

keys.extend(spawn_apps)
