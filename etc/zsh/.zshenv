# Environment file for zsh(1).

export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'
export PAGER='/usr/bin/less'
export BROWSER='/usr/bin/qutebrowser'

if [ "$TERM" = "rxvt-unicode-256color" ]; then
  export TERM="rxvt-unicode"
fi

