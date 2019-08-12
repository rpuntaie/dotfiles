#order: [.zshenv] [.zprofile if login] [.zshrc if interactive] [.zlogin if login]

. $XDG_CONFIG_HOME/sh/interactive

export ZGEN_DIR="$XDG_STATE_HOME/.zgen"
if [[ ! -s "$ZGEN_DIR/zgen.zsh" ]]; then
  echo "Zgen not found, bootstrapping."
  mkdir -p "$ZGEN_DIR"
  curl -L https://raw.githubusercontent.com/tarjoilija/zgen/master/zgen.zsh > "$ZGEN_DIR/zgen.zsh"
fi
source "$ZGEN_DIR/zgen.zsh"

DISABLE_AUTO_TITLE=true
DISABLE_AUTO_UPDATE=true

export KEYTIMEOUT=1

ZSH_THEME="rpuntaie"
ZSH_CUSTOM="${ZDOTDIR:-$HOME}"

_Z_DATA=$XDG_CACHE_HOME/z

# after a change do: $ zgen reset
zgen oh-my-zsh

zgen oh-my-zsh plugins/vi-mode
zgen oh-my-zsh plugins/vim-interaction

zgen oh-my-zsh plugins/history-substring-search
zgen oh-my-zsh plugins/history
zgen oh-my-zsh plugins/z
zgen oh-my-zsh plugins/fzf

zgen oh-my-zsh plugins/git
ORPROMPT=$RPS1
zgen oh-my-zsh plugins/git-prompt
RPROMPT=$ORPROMPT

zgen oh-my-zsh plugins/mercurial
zgen oh-my-zsh plugins/svn

zgen oh-my-zsh plugins/battery
zgen oh-my-zsh plugins/bgnotify

zgen load zsh-users/zsh-autosuggestions
zgen load zsh-users/zsh-completions
zgen load zsh-users/zsh-syntax-highlighting

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

# avoid ZLE command line
bindkey -M vicmd : edit-command-line

unsetopt correct

. $XDG_CONFIG_HOME/zsh/fzf_options.zsh

