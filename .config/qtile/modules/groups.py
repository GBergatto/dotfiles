from libqtile.config import Group, Key, KeyChord, Match
from libqtile.lazy import lazy

from modules.common import mod
from modules.state import toggling_state

group_matches = [
    ["brave", "brave-browser", "firefox", "Tor Browser", "Navigator"],
    ["Alacritty",  "thunar"],
    ["obsidian"],
    ["okular", "mpv"],
    ["code-oss", "kdenlive", "MATLAB R2023b","MATLAB R2023b - academic use", "sun-awt-X11-XFramePeer","Inkscape", "gimp", "Com.github.xournalpp.xournalpp"],
    ["anki", "keepassxc"],
]

group_keys = []
other_groups = []
num_groups = []
for i in range(len(group_matches)):
    num_groups.append(
        Group(
            str(i+1),
            matches=[Match(wm_class=x) for x in group_matches[i]],
        )
    )

for group in num_groups:
    group_keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                group.name,
                lazy.group[group.name].toscreen(),
                desc=f"Switch to group {group.name}",
            ),
            # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                group.name,
                lazy.window.togroup(group.name),
                desc=f"Move focused window to group {group.name}",
            ),
            # mod + ctrl + group = toggle pressed group
            Key(
                [mod, "control"],
                group.name,
                lazy.group[group.name].function(
                    lambda pressed_group: toggling_state.toggle_group(pressed_group)
                ),
                desc=f"Toggle group {group.name}",
            ),
        ]
    )


app_keychord = KeyChord([mod], "g", [])
other_groups.extend(
    [
        Group(
            name="TODO",
            spawn="todoist",
            matches=[
                Match(wm_class="morgen"),
                Match(wm_class="todoist"),
            ],
        ),
        Group(
            name="MSG",
            matches=[
                Match(wm_class="telegram-desktop"),
                Match(wm_class="thunderbird"),
                Match(wm_class="mail"),
                Match(wm_class="discord"),
            ],
        ),
    ]
)
app_keychord.submappings.extend(
    [
        Key(
            [],
            "t",
            lazy.group["TODO"].toscreen(),
            desc="Focus TODO group",
        ),
        Key(
            [],
            "m",
            lazy.group["MSG"].toscreen(),
            desc="Focus MSG group",
        ),
    ]
)

group_keys.append(app_keychord)

groups = []
groups.extend(num_groups)
groups.extend(other_groups)

#@hook.subscribe.client_new
#def assign_app_group(client):
#TODO: check if the group where the app will go is in on a screen
# if not, go to that group
#client.togroup(group)

