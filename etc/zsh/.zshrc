#order: [.zshenv] [.zprofile if login] [.zshrc if interactive] [.zlogin if login]

export ZGEN_DIR="$XDG_STATE_HOME/zgen"
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
#ZSH_THEME="rpuntaiemin"
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

zgen load Aloxaf/fzf-tab

zgen load akarzim/zsh-docker-aliases

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
export PATH="$NPM_PACKAGES/bin:$PATH"
#unset MANPATH
#export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# yay -S miniconda3
condaa() {
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
}
