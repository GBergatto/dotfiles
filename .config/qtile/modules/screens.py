from datetime import datetime
from libqtile.config import Screen
from libqtile import bar, widget

class MyPalette:
    transparent=  '#00000000'
    background=   '#000'#'#0D0F14'
    foreground=   '#FFFFFF'
    gray=         '#D3D3D3'
    graydark=     '#6A6F87'
    primary=      '#0C5685'
    secondary=    '#618298'


palette = MyPalette()

def init_widgets():
    return [
        widget.GroupBox(
            font="Hack",
            fontsize=12,
            spacing=5,
            highlight_method="block",
            disable_drag=True,
            foreground=palette.foreground,
            background=palette.background,
            active=palette.foreground,
            inactive=palette.graydark,
            this_current_screen_border=palette.primary,
            this_screen_border=palette.secondary,
            other_screen_border=palette.graydark,
            other_current_screen_border=palette.graydark,
            use_mouse_wheel=False,
            rounded=False,
            margin_x=3,
            margin_y=1,
            padding_x=3,
            padding_y=3,
        ),
        widget.CurrentLayoutIcon(
            #custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=palette.foreground,
            background=palette.primary,
            scale=0.6,
        ),
        widget.Spacer(),
        widget.WindowName(
            font="Hack",
            fontsize=12,
            foreground = palette.foreground,
            empty_group_string='',
            padding=10,
            width=bar.CALCULATED,
        ),
        widget.Spacer(),
        widget.Systray(
            background=palette.background,
            padding=5,
        ),
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=palette.foreground,
            background=palette.background,
        ),
        #widget.Battery(
        #    font="Hack",
        #    fontsize=12,
        #    background=palette.background,
        #    format="{percent:2.0%}",
        #    charge_char="",
        #    discharge_char="",
        #),
        widget.ThermalSensor(
            font="Hack",
            fontsize=12,
            foreground=palette.foreground,
            background=palette.background,
            threshold=90,
            fmt="{}",
            padding=8,
        ),
        widget.CPU(
            font="Hack",
            fontsize=12,
            format="{load_percent:2.0f}%",
            background=palette.background,
        ),
        widget.KeyboardLayout(
            font="Hack",
            fontsize=12,
            foreground=palette.foreground,
            background=palette.background,
            configured_keyboards=["it", "us", "de"],
        ),
        #widget.PulseVolume(
        #    font="Hack",
        #    fontsize=12,
        #    foreground=palette.foreground,
        #    background=palette.background,
        #    fmt="{}",
        #    padding=5,
        #),
        #widget.Volume(
        #    font="Hack",
        #    fontsize=12,
        #    foreground=palette.foreground,
        #    background=palette.background,
        #    fmt="{}",
        #    padding=5,
        #),
        #widget.Sep(
        #    linewidth=1,
        #    padding=10,
        #    foreground=palette.foreground,
        #    background=palette.background,
        #),
        #widget.Countdown(
        #    font="Hack",
        #    fontsize=12,
        #    foreground=palette.foreground,
        #    background=palette.background,
        #    format="{D}d {H}h",
        #    date=datetime(2024, 7, 8, 8, 0),
        #    update_interval=3600,
        #    padding=5,
        #),
        widget.Clock(
            font="Hack",
            fontsize=14,
            foreground=palette.foreground,
            background=palette.primary,
            format="%Y/%m/%d %a %H:%M",
            padding=10,
        ),
    ]


def init_widgets_2():
    w = init_widgets()
    del w[5:6]
    return w


screens = [
    Screen(
        top=bar.Bar(
            widgets=init_widgets(),
            size=24,
            background=palette.background,
        ),
    ),
    Screen(
        top=bar.Bar(
            widgets=init_widgets_2(),
            size=24,
            background=palette.background,
        ),
    ),
]

