typeset -U path PATH
path+=('/home/gb/.local/bin')
path+=('/usr/local/sbin')
path+=('/usr/local/bin')
path+=('/usr/bin')
path+=('/usr/lib/jvm/default/bin')
path+=('/usr/bin/site_perl')
path+=('/usr/bin/vendor_perl')
path+=('/usr/bin/core_perl')
path+=('/home/gb/Applications/')
path+=('/home/gb/scripts')
path+=('/home/gb/.local/share/nvim/mason')
#path+=('/home/gb/.local/bin/zig-linux-x86_64-0.14.0')
PATH=/opt/flutter/bin:$PATH
export PATH

export FPATH=$HOME/.zsh_completion:$FPATH

# XDG Base Directory
export XDG_DATA_HOME=~/.local/share
export XDG_CONFIG_HOME=~/.config
export XDG_STATE_HOME=~/.local/state
export XDG_CACHE_HOME=~/.cache

export CARGO_HOME=$XDG_DATA_HOME/cargo
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export GOPATH=$XDG_DATA_HOME/go
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export GNUPGHOME=$XDG_DATA_HOME/gnupg

# Alacritty same size on different monitors
export WINIT_X11_SCALE_FACTOR=1.5

# Clipmenu
export CM_LAUNCHER='rofi'
export CM_SELECTIONS='clipboard' # don't copy selections
export CM_IGNORE_WINDOW='[Kk]ee[Pp]ass' # don't copy passwords

# Dmenu for scripts
export DMENU="dmenu -i -nb #191919 -nf #0c5685 -sb #0c5685 -sf #191919 -fn Inconsolata:bold:pixelsize=16"

export GTK_THEME=Adwaita:dark

export HISTCONTROL=ignoreboth:erasedups
export PAGER='less'
export EDITOR='nvim'
export VISUAL='nvim'

# Flutter, Android and Java
# deprecated: export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
export ANDROID_SDK_ROOT='/home/gb/Android/Sdk'
export ANDROID_SDK_ROOT='/opt/android-sdk/'

export JAVA_HOME='/usr/lib/jvm/java-17-openjdk'
export PATH=$PATH:$JAVA_HOME/bin

# Matlab
export AWT_TOOLKIT=MToolkit # useless?
export _JAVA_AWT_WM_NONREPARENTING=1

