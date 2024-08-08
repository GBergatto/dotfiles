"""
My Qtile config!
"""
import os
import subprocess
from libqtile import layout, hook
from libqtile.config import Click, Drag, Match
from libqtile.lazy import lazy

from modules.common import mod
from modules.groups import group_keys, groups  # noqa
from modules.keys import keys
from modules.screens import screens
from modules.lazy_functions import groupbox_toggle_group, groupbox_reset_toggling_group
from modules.hooks import reset_toggling_on_group_change  # noqa

keys.extend(group_keys)
screens = screens

#@hook.subscribe.startup_once
#def start_once():
#    home = os.path.expanduser("~")
#    subprocess.call([home + "/.config/qtile/scripts/autostart.sh"])


# ===== Layouts =====
layout_theme = {
    "border_width": 2,
    "margin": 4,
    "border_focus": "e1acff",
    "border_normal": "1D2330",
}

layouts = [
    layout.MonadTall(
        single_border_width=0,
        new_client_position="top",
        single_margin=0, **layout_theme,
    ),
    layout.Max(margin=0, border_width=0),
    #layout.Tile(master_len=3, **layout_theme),
    #layout.Stack(**layout_theme),
]

# ===== Widgets =====
widget_defaults = dict(
    font="Hack",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()


# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
        warp_pointer=True,
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

cursor_warp = True
follow_mouse_focus = True

dgroups_key_binder = None
dgroups_app_rules = []
bring_front_click = "floating_only"
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="matplotlib"),
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="Upload image"),  # flameshot
        Match(title="Figure 1"),  # matlab
        Match(title="Figure 2"),
        Match(title="Figure 3"),
        Match(title="Figure 4"),
        Match(title="Figure 5"),
    ]
)

focus_on_window_activation = "smart"
reconfigure_screens = True
auto_fullscreen = True
auto_minimize = True
wmname = "qtile"

