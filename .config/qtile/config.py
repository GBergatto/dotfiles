# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# https://gitlab.com/LongerHV/.dotfiles/-/blob/master/.config/qtile/config.py


import os
import re
import socket
import subprocess
import datetime
from typing import List  # noqa: F401
from libqtile import qtile
from libqtile import layout, bar, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, Rule
from libqtile.command import lazy
from libqtile.widget import Spacer
#import arcobattery

# mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')

myTerm = "alacritty"


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


keys = [

    # Most of our keybindings are in sxhkd file - except these

    # SUPER + FUNCTION KEYS
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),

    # SUPER + SHIFT KEYS
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),

    # QTILE LAYOUT KEYS
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),

    # CHANGE FOCUS
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),


    # RESIZE UP, DOWN, LEFT, RIGHT
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),
    Key([mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),


    # FLIP LAYOUT FOR MONADTALL/MONADWIDE
    Key([mod, "shift"], "f", lazy.layout.flip()),

    # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),

    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),

]

groups = []

group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ]
group_labels = ["www", "sys", "dev", "pkm", "pdf",
    "lbr", "msg", "gfx", "vb", "mix", ]
group_layouts = ["monadtall", "monadtall", "monadtall",  "max", "monadtall",
    "monadtall", "monadtall", "monadtall", "max", "monadtall", ]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i].upper(),
        ))

for i in groups:
    keys.extend([

                    # CHANGE WORKSPACES
                    Key([mod], i.name, lazy.group[i.name].toscreen()),
                    Key([mod], "Tab", lazy.screen.next_group()),
                    Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
                    Key(["mod1"], "Tab", lazy.screen.toggle_group()),

                    # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
                    #Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
                    # MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
                    Key([mod, "shift"], i.name, lazy.window.togroup(
                            i.name), lazy.group[i.name].toscreen()),
                ])


def init_layout_theme():
    return {"margin": 5,
        "border_width": 2,
        "border_focus": "#0c5685",
        "border_normal": "#4c566a"
    }


layout_theme = init_layout_theme()


layouts = [
    layout.MonadTall(**layout_theme),
    # layout.MonadWide(margin=4, border_width=2, border_focus="#5e81ac", border_normal="#4c566a"),
    # layout.Matrix(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Floating(**layout_theme),
    # layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme)
]

# COLORS FOR THE BAR
# Theme name : ArcoLinux Default


def init_colors():
    return [["#2F343F", "#2F343F"],  # color 0
        ["#2F343F", "#2F343F"],  # color 1
        ["#c0c5ce", "#c0c5ce"],  # color 2
        ["#fba922", "#fba922"],  # color 3
        ["#3384d0", "#3384d0"],  # color 4
        ["#f3f4f5", "#f3f4f5"],  # color 5
        ["#cd1f3f", "#cd1f3f"],  # color 6
        ["#62FF00", "#62FF00"],  # color 7
        ["#6790eb", "#6790eb"],  # color 8
        ["#a9a9a9", "#a9a9a9"]]  # color 9


colors = init_colors()

BLACK = '#2F343F'
RED = '#ec5f67'
GREEN = '#99c794'
YELLOW = '#fac863'
BLUE = '#0c5685'
MAGENTA = '#c594c5'
CYAN = '#5fb3b3'
WHITE = '#ffffff'


# WIDGETS FOR THE BAR

def init_widgets_defaults():
    return dict(font="Noto Sans",
                fontsize=12,
                padding=2,
                background=colors[1])


widget_defaults = init_widgets_defaults()


def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
        widget.GroupBox(
            font="Noto Sans",
            fontsize=14,
            spacing=5,
            disable_drag=True,
            active=WHITE,
            inactive=colors[9],
            rounded=False,
            highlight_method="block",
            this_current_screen_border=BLUE,
            foreground=colors[2],
            background=colors[1],
            margin_x=3,
            margin_y=1,
            padding_x=4,
            padding_y=7,
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
            foreground=WHITE,
            background=BLUE,
            scale=0.6
        ),
        widget.WindowName(
            font="Noto Sans",
            fontsize=12,
            foreground=colors[5],
            background=colors[1],
            padding=10,
        ),
        widget.Systray(
            background=colors[0],
            padding=5,
        ),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors[5],
            background=colors[0]
        ),
        widget.Battery(
            font="Noto Sans",
            format='{percent:2.0%}',
            charge_char='',
            discharge_char='',
        ),
        widget.ThermalSensor(
            foreground=colors[5],
            # background=colors[4],
            font="Noto Sans",
            threshold=90,
            fmt='{}',
            padding=8
        ),
        # widget.CheckUpdates(
        #     update_interval=3600,
        #     distro="Arch_checkupdates",
        #     display_format="▼ {updates}",
        #     no_update_string="",
        #     foreground=colors[5],
        #     background=colors[1],
        #     colour_have_updates=colors[5],
        #     colour_no_updates=colors[5],
        #     mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
        #         myTerm + ' -e sudo pacman -Syu')},
        #     padding=5,
        # ),
        widget.CPU(
            format='{load_percent}%',
            # freq_current doesn't work!
            # format='{freq_current}GHz {load_percent}%',
        ),
        widget.Memory(
            foreground=colors[5],
            # background=colors[4],
            font="Noto Sans",
            fmt='{}',
            format='{MemUsed: .2f} {mm}B',
            measure_mem="G",
            padding=5
        ),
        widget.KeyboardLayout(
            foreground=colors[5],
            configured_keyboards=['it', 'gb', 'de'],
        ),
        widget.Volume(
            foreground=colors[5],
            background=colors[1],
            font="Noto Sans",
            fmt='{}',
            padding=5
        ),
        widget.Sep(
            linewidth=1,
            padding=5,
            foreground=colors[5],
            background=colors[0]
        ),
        widget.Countdown(
            foreground=colors[5],
            background=colors[1],
            format='{D}d', # {H}h',
            date=datetime.datetime(2023, 6, 12, 8, 30),
            update_interval=3600,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                    "brave https://docs.google.com/spreadsheets/d/1ZnG2oIPEjPNAmyL9alippurc_EnW-IU_hZ941jD6kRA/edit?usp=sharing")},
            padding=5
        ),
        widget.Clock(
            foreground=colors[5],
            background=BLUE,
            fontsize=14,
            format="%Y/%m/%d %a %H:%M",
            padding=10,
        ),
    ]
    return widgets_list


widgets_list = init_widgets_list()


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    del widgets_screen2[3:-1] # remove systray and extra info
    return widgets_screen2

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=26, opacity=1.0)),
        Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=26, opacity=1.0)), # external monitor
    ]


screens = init_screens()


# MOUSE CONFIGURATION
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

dgroups_key_binder = None
dgroups_app_rules = []

# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME
# BEGIN


@hook.subscribe.client_new
def assign_app_group(client):
    d = {}

    # To get VM_CLASS run $ xprop | grep WM_CLASS | awk '{print $4}'
    # and click on the target window

    d[group_names[0]] = ["Navigator", "firefox", "Brave",
        "Brave-browser", "brave", "brave-browser", ]
    d[group_names[1]] = ["Alacritty", "alacritty", "Thunar", "thunar"]
    d[group_names[2]] = ["Code", "code", "Neovide", "neovide", "sun-awt-X11-XFramePeer"]
    d[group_names[3]] = ["Obsidian", "obsidian", ]
    d[group_names[4]] = ["Okular", "okular"] # "xournalpp", "Xournalpp"]
    d[group_names[5]] = ["libreoffice-startcenter", "libreoffice", "libreoffice-calc", "libreoffice-writer", "libreoffice-impress",
        "libreoffice-math", "libreoffice-draw", ]
    d[group_names[6]] = ["Mail", "Thunderbird", "telegram-desktop",
        "TelegramDesktop" "Discord", "discord", "spotify", "Spotify", "todoist", "Todoist", "morgen", "Morgen"]
    d[group_names[7]] = ["Vlc", "vlc", "gl", "mpv", "Gimp",
        "gimp", "Inkscape", "org.inkscape.Inkscape"]
    d[group_names[8]] = ["VirtualBox Manager", "VirtualBox Machine",
        "Vmplayer", "virtualbox manager", "virtualbox machine", "vmplayer", ]
    d[group_names[9]] = ["Anki", "anki"]
    ######################################################################################

    wm_class = client.window.get_wm_class()[0]

    # TODO: remove douplicate names with a .lower()
    for i in range(len(d)):
        if wm_class in list(d.values())[i]:
            group = list(d.keys())[i]
            client.togroup(group)
            client.group.cmd_toscreen(toggle=False)

# END
# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME


main = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])


@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True


floating_types = ["notification", "toolbar", "splash", "dialog"]


follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
                                      # Run the utility of `xprop` to see the wm class and name of an X client.
                                      *layout.Floating.default_float_rules,
                                      Match(wm_class='confirmreset'),  # gitk
                                      Match(wm_class='makebranch'),  # gitk
                                      Match(wm_class='maketag'),  # gitk
                                      Match(wm_class='ssh-askpass'),  # ssh-askpass
                                      Match(title='branchdialog'),  # gitk
                                      Match(title='pinentry'),  # GPG key password entry
                                      Match(wm_class='Arcolinux-welcome-app.py'),
                                      Match(wm_class='Arcolinux-tweak-tool.py'),
                                      Match(wm_class='Arcolinux-calamares-tool.py'),
                                      Match(wm_class='confirm'),
                                      Match(wm_class='dialog'),
                                      Match(wm_class='download'),
                                      Match(wm_class='error'),
                                      Match(wm_class='file_progress'),
                                      Match(wm_class='notification'),
                                      Match(wm_class='splash'),
                                      Match(wm_class='toolbar'),
                                      Match(wm_class='Arandr'),
                                      Match(wm_class='sxiv'),
                                      Match(wm_class='kcalc'),
                                      Match(wm_class='arcolinux-logout'),
                                      Match(wm_class='xfce4-terminal'),
                                      # Match(title='Android Emulator - Pixel_4_API_30:5554'),
                                      Match(title='Upload image'),  # flameshot
                                      Match(title='Figure 1'),  # matlab graph window
                                      Match(title='Figure 2'),
                                      Match(title='Figure 3'),
                                      Match(title='Media viewer'),
                                      Match(wm_class="blueberry.py"),


                                  ],  fullscreen_border_width=0, border_width=0)
auto_fullscreen = True

focus_on_window_activation = "smart"  # or smart

wmname = "LG3D"
