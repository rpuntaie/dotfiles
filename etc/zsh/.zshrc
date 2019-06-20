export ZGEN_DIR="${ZDOTDIR:-$HOME}/.zgen/"
if [[ ! -s "${ZDOTDIR:-$HOME}/.zgen/zgen.zsh" ]]; then
  echo "Zgen not found, bootstrapping."
  mkdir -p "${ZDOTDIR:-$HOME}/.zgen"
  curl -L https://raw.githubusercontent.com/tarjoilija/zgen/master/zgen.zsh > "${ZDOTDIR:-$HOME}/.zgen/zgen.zsh"
fi
source "${ZDOTDIR:-$HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
  echo "Creating a zgen save"

  # Disable loading default Prezto modules
  # This is necessary due to a quirk of zgen that will load these plugins after
  # our custom plugins, overwriting our customizations
  # https://github.com/tarjoilija/zgen/issues/74
  export ZGEN_PREZTO_LOAD_DEFAULT=0

  # prezto options
  zgen prezto editor key-bindings 'vi'
  zgen prezto prompt theme 'rpuntaie'

  # prezto and modules
  zgen prezto

  zgen prezto
  zgen prezto git
  zgen prezto environment
  zgen prezto terminal
  zgen prezto editor
  zgen prezto directory
  zgen prezto spectrum
  zgen prezto utility
  zgen prezto prompt
  zgen prezto archive
  #zgen prezto ruby

  zgen prezto command-not-found
  zgen prezto fasd
  zgen prezto history-substring-search
  zgen prezto syntax-highlighting

  zgen load junegunn/fzf shell

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load tarruda/zsh-autosuggestions
  zgen load eendroroy/zed-zsh

  #     # Default plugins
  #     zgen load sorin-ionescu/prezto modules/environment
  #     zgen load sorin-ionescu/prezto modules/terminal
  #     zgen load sorin-ionescu/prezto modules/editor
  #     zgen load sorin-ionescu/prezto modules/history
  #     zgen load sorin-ionescu/prezto modules/directory
  #     zgen load sorin-ionescu/prezto modules/spectrum
  #     zgen load sorin-ionescu/prezto modules/utility
  #     zgen load sorin-ionescu/prezto modules/completion
  #     # zgen load sorin-ionescu/prezto modules/prompt

  #     # zgen load sorin-ionescu/prezto modules/git
  #     # zgen load sorin-ionescu/prezto modules/fasd
  #     zgen load sorin-ionescu/prezto modules/history-substring-search

  #     zgen load robbyrussell/oh-my-zsh plugins/docker
  #     zgen load robbyrussell/oh-my-zsh plugins/fasd
  #     # zgen load zsh-users/zaw
  #     zgen load zsh-users/zsh-autosuggestions
  #     zgen load zsh-users/zsh-completions
  #     zgen load chriskempson/base16-shell
  #     zgen load martinlindhe/base16-iterm2

  #     # zgen prezto homebrew
  #     # zgen prezto archive
  #     zgen prezto command-not-found
  #     # zgen prezto osx
  #     zgen prezto tmux
  #     zgen prezto ssh

  #     zgen load unixorn/autoupdate-zgen
  #     zgen load zsh-users/zsh-syntax-highlighting

  zgen save
fi

export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion

[[ -d "$XDG_DATA_HOME/zsh" ]] || mkdir -p "$XDG_DATA_HOME/zsh"

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

alias cp='cp -i'
alias mv='mv -i'
alias la='ls -lAh'
alias ll='ls -lh'
alias r='ranger'
alias wd='. wd.sh'

alias wttr='curl wttr.in'
alias moon='curl wttr.in/Moon'
alias ax='git annex'

alias :e="$EDITOR"
alias :q=exit

setopt correct
setopt extendedglob
setopt interactivecomments
setopt promptsubst

