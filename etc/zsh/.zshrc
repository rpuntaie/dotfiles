source $ZDOTDIR/antigen.zsh
source $ZDOTDIR/bgnotify.zsh
source $ZDOTDIR/completion.zsh

###
# Antigen

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle dnf

# Load the theme.
antigen theme minimal

# Tell Antigen that you're done.
antigen apply

###
# History

[[ -d "$XDG_DATA_HOME/zsh" ]] || mkdir -p "$XDG_DATA_HOME/zsh"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_DATA_HOME/zsh/zhistory"

setopt extendedhistory
setopt histignoredups
setopt histverify
setopt incappendhistory

###
# Completion

###
# Look

autoload colors

colors
if (( $+commands[dircolors] ))
then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

###
# Key bindings

# Use vim mode, but keep handy emacs keys in insert mode:
bindkey -v
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^[[3~' delete-char
bindkey -M viins '^A'    beginning-of-line
bindkey -M viins '^E'    end-of-line
bindkey -M viins '^K'    kill-line
bindkey -M viins '^N'    down-line-or-history
bindkey -M viins '^P'    up-line-or-history
bindkey -M viins '^R'    history-incremental-search-backward
bindkey -M viins '^U'    backward-kill-line
bindkey -M viins '^W'    backward-kill-word

###
# Command aliases

alias cp='cp -i'
alias mv='mv -i'
alias la='ls -lAh'
alias ll='ls -lh'
alias r='ranger'
alias wd='. wd.sh'

alias wttr='curl wttr.in'
alias moon='curl wttr.in/Moon'
alias ax='git annex'

# In zsh vim mode, I sometimes forget I'm not in vim:
alias :e="$EDITOR"
alias :q=exit

###
# Misc

setopt correct
setopt extendedglob
setopt interactivecomments
setopt promptsubst

# Notify after some time
function bgnotify_formatted { ## args: (exit_status, command, elapsed_seconds)
  elapsed="$(( $3 % 60 ))s"
  (( $3 >= 60 )) && elapsed="$((( $3 % 3600) / 60 ))m $elapsed"
  (( $3 >= 3600 )) && elapsed="$(( $3 / 3600 ))h $elapsed"
  [ $1 -eq 0 ] && notify-send "Completed in $elapsed" "$2" || \
  notify-send -u critical "Failed after $elapsed" "$2"
}

# Window title
functionreexec() {
  local a=${${1## *}[(w)1]}  # get the command
  local b=${a##*\/}   # get the command basename
  a="${b}${1#$a}"     # add back thearameters
  a=${a//\%/\%\%}     # escaperint specials
  a=$(print -Pn "$a" | tr -d "\t\n\v\f\r")  # remove fancy whitespace
  a=${(V)a//\%/\%\%}  # escape non-visibles andrint specials

  case "$TERM" in
    screen|screen.*)
      # See screen(1) "TITLES (naming windows)".
      # "\ek" and "\e\" are the delimiters for screen(1) window titles
      rint -Pn "\ek%-3~ $a\e\\" # set screen title.  Fix vim: ".
      rint -Pn "\e]2;%-3~ $a\a" # set xterm title, via screen "Operating System Command"
      ;;
    rxvt|rxvt-unicode|rxvt-unicode-256color|xterm|xterm-color|xterm-256color)
      rint -Pn "\e]2;%m:%-3~ $a\a"
      ;;
  esac
}
