#order: [.zshenv] [.zprofile if login] [.zshrc if interactive] [.zlogin if login]

DISABLE_AUTO_TITLE=true
DISABLE_AUTO_UPDATE=true
export KEYTIMEOUT=1

ZSH_THEME="rpuntaie"
#ZSH_THEME="rpuntaiemin"
ZSH_CUSTOM="${ZDOTDIR:-$HOME}"

export ZGEN_DIR="$XDG_STATE_HOME/zgenom"
if [[ ! -s "$ZGEN_DIR/zgenom.zsh" ]]; then
  echo "zgenom not found, bootstrapping."
  git clone https://github.com/jandamm/zgenom.git "$ZGEN_DIR"
fi
source "$ZGEN_DIR/zgenom.zsh"

ORPROMPT=$RPS1
RPROMPT=$ORPROMPT

zgenom autoupdate

if ! zgenom saved; then
  # after a change do: $ zgenom reset
  zgenom ohmyzsh
  zgenom ohmyzsh plugins/vi-mode
  zgenom ohmyzsh plugins/vim-interaction
  zgenom ohmyzsh plugins/history-substring-search
  zgenom ohmyzsh plugins/history
  zgenom ohmyzsh plugins/z
  zgenom ohmyzsh plugins/fzf
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/git-prompt
  zgenom ohmyzsh plugins/mercurial
  zgenom ohmyzsh plugins/svn
  zgenom ohmyzsh plugins/battery
  zgenom ohmyzsh plugins/bgnotify
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-completions
  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom load Aloxaf/fzf-tab
  zgenom load akarzim/zsh-docker-aliases
  zgenom load wfxr/forgit
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

# avoid ZLE command line
bindkey -M vicmd : edit-command-line

unsetopt correct

. $XDG_CONFIG_HOME/zsh/fzf_options.zsh

. $XDG_CONFIG_HOME/sh/interactive


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/roland/.local/google-cloud-sdk/path.zsh.inc' ]; then . '/home/roland/.local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/roland/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/roland/.local/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# TAB fzf complete names in current folder (CTRL-T to fzf on full tree)
enable-fzf-tab

export NPM_PACKAGES="${XDG_STATE_HOME}/npm"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
export PATH="$NPM_PACKAGES/bin:$PATH:$XDG_STATE_HOME/zgenom/forgit/bin"
#unset MANPATH
#export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

[ -e /home/roland/msrc/flutter/bin ] && export PATH="/home/roland/msrc/flutter/bin:$PATH"

# yay -S miniconda3
condaa() {
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
}

#zoxide
unalias z
eval "$(zoxide init zsh)"


eval "$(mise activate zsh)"
eval "$(mise completion zsh)"

eval "$(uv generate-shell-completion zsh)"
