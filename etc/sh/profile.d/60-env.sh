if [ "$TERM" = "rxvt-unicode-256color" ]; then
  export TERM="rxvt-unicode"
fi

HISTFILE="$XDG_STATE_HOME/.bash_history"

# Default:
export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'
export PAGER='/usr/bin/less'
export BROWSER='/usr/bin/links'

# Colours for less:
LESS_TERMCAP_me="$(printf '\033[0m')"
LESS_TERMCAP_se="$(printf '\033[0m')"
LESS_TERMCAP_so="$(printf '\033[30;43m')"
LESS_TERMCAP_ue="$(printf '\033[0m')"
LESS_TERMCAP_us="$(printf '\033[32m')"
LESS_TERMCAP_mb="$(printf '\033[34m')"
LESS_TERMCAP_md="$(printf '\033[31m')"
export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_se \
       LESS_TERMCAP_so LESS_TERMCAP_ue LESS_TERMCAP_us
