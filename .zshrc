# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History in cache directory
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# escape urls
# https://github.com/zsh-users/zsh/blob/master/Functions/Zle/url-quote-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Keybindings
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# tmux
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey "^U" backward-kill-line
bindkey "^K" kill-line

bindkey -v
# history seach
bindkey "^R" history-incremental-pattern-search-backward

autoload -U colors && colors

# Autocompletion
autoload -U compinit && compinit -u
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Auto complete with case insenstivity


### Solve issues with w/ autosuggest
# Speed up pasting
# https://github.com/zsh-users/zsh-autosuggestions/issues/238#issuecomment-389324292
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# https://github.com/zsh-users/zsh-autosuggestions/issues/351
# https://github.com/zsh-users/zsh-autosuggestions/issues/489
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)
###
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Setopt
setopt GLOB_DOTS # Include hidden files
#share commands between terminal instances or not
unsetopt SHARE_HISTORY
#setopt SHARE_HISTORY

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

### ALIASES ###

alias pacman='sudo pacman --color auto'

# lxd and ROS
alias rossh='lxc exec ros -- sudo --login --user ubuntu'
alias stoplxd='sudo systemctl stop lxd.service lxd.socket'

#dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

#youtube download
alias dwwl="yt-dlp -i -f mp4 --embed-chapters --yes-playlist 'https://www.youtube.com/playlist?list=PLQa-JAExqnKHKa_CyWIJGBtIM7zOCxJix' --path '/home/gb/Videos/0MWL' --restrict-filenames"
alias dwpl="yt-dlp -i -f mp4 --embed-chapters --yes-playlist --path '/home/gb/Videos/' -o 'PL %(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' --restrict-filenames"
alias dwvi="yt-dlp -i -f mp4 --embed-chapters --path '/home/gb/Videos/' --restrict-filenames"
alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --path '/home/gb/Videos/' ---restrict-filenames"

#alias mpv="prime-run mpv"

alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "

#newsboat
alias nb='newsboat'
alias nburls='nvim ~/.config/newsboat/urls'
alias nbconf='nvim ~/.config/newsboat/config'

#script to control fan speed
alias checkthermal='cat /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy'

#CTFs
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

#list
alias ls='exa -al --color=always --group-directories-first'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

eval "$(starship init zsh)"

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
