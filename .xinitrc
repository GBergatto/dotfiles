#!/bin/sh

[ -f ~/.xprofile ] && . ~/.xprofile


# this used to be inside qtile autostart
function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
  then
    $@&
  fi
}

run clipmenud &
run nm-applet &

#starting user applications at boot time
nitrogen --restore &
run dropbox &
run flameshot &
run play-with-mpv &
picom -b &
hhpc -i 5 &

qtile start

