export ZGEN_DIR="${ZDOTDIR:-$HOME}/.zgen/"
if [[ ! -s "${ZDOTDIR:-$HOME}/.zgen/zgen.zsh" ]]; then
  echo "Zgen not found, bootstrapping."
  mkdir -p "${ZDOTDIR:-$HOME}/.zgen"
  curl -L https://raw.githubusercontent.com/tarjoilija/zgen/master/zgen.zsh > "${ZDOTDIR:-$HOME}/.zgen/zgen.zsh"
fi
source "${ZDOTDIR:-$HOME}/.zgen/zgen.zsh"

DISABLE_AUTO_TITLE=true
DISABLE_AUTO_UPDATE=true

ZSH_THEME="rpuntaie"
ZSH_CUSTOM="${ZDOTDIR:-$HOME}"

# after a change do:
# $ zgen reset
zgen oh-my-zsh

zgen oh-my-zsh plugins/history-substring-search
zgen oh-my-zsh plugins/history
zgen oh-my-zsh plugins/z
zgen oh-my-zsh plugins/fzf

zgen oh-my-zsh plugins/git
zgen oh-my-zsh plugins/mercurial
zgen oh-my-zsh plugins/svn

zgen oh-my-zsh plugins/battery
zgen oh-my-zsh plugins/bgnotify
zgen oh-my-zsh plugins/vi-mode
zgen oh-my-zsh plugins/vim-interaction

zgen load zsh-users/zsh-autosuggestions
zgen load zsh-users/zsh-completions
zgen load zsh-users/zsh-syntax-highlighting

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_DATA_HOME/zsh/zhistory"

setopt extendedhistory
setopt histignoredups
setopt histverify
setopt incappendhistory

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

# insert mode emacs keys
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

alias cp='cp -i'
alias mv='mv -i'
alias la='ls -lAh'
alias ll='ls -lh'
alias r='ranger'

alias wttr='curl wttr.in'
alias moon='curl wttr.in/Moon'
alias ax='git annex'

alias :e="$EDITOR"
alias :q=exit

#setopt correct
unsetopt correct
setopt extendedglob
setopt interactivecomments
setopt promptsubst

