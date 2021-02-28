# Interactive shell aliases

#colors set via X11/Xresources
#alias urxvt='urxvt -bg black -fg white'
#alias xterm='xterm -fa monaco -fs 10 -bg black -fg white'

# Generic aliases:
alias r='ranger'
alias cp='cp -i'
alias grep='grep --color=auto'
alias la='ls -lAh'
alias ll='ls -lh --time-style=long-iso -tr'
alias lsd='ls -d'
alias ls='ls -A --color=auto --quoting-style=literal'
alias lt='ls -tr'
alias mv='mv -i'
alias ol='chromium "$( lt | tail -n 1)"'
alias chrome='chromium'

alias pipiu='pip install --user'
alias pipui='sudo pip uninstall'

#weather
alias wttr='curl https://wttr.in'
alias moon='curl https://wttr.in/Moon'

# Server only aliases (mostly additional safety):
if [ -n "$SSH_CONNECTION" ]; then
  alias rm='rm -i'
fi

# Random other aliases:
alias cc='gcc -std=c11 -pedantic -Wall -Wextra -Wbad-function-cast -Wcast-align -Wcast-qual -Wconversion -Wfloat-equal -Wformat=2 -Wlogical-op -Wmissing-declarations -Wmissing-prototypes -Wpointer-arith -Wshadow -Wstrict-prototypes -Wwrite-strings'
alias poscc='gcc -std=c11 -pedantic -Wall -Wextra'

alias ax='git annex'
alias gmm='git merge'
alias gms='git merge --squash'
alias gtags="git tag -l --sort=-creatordate --format='%(creatordate:short):  %(refname:short)'"

#. <name>/bin/activate and deactivate to exit
alias venv='python -m venv --system-site-packages --symlinks'

alias xtex='xelatex -interaction=nonstopmode'

alias sp='sudo pacman'
alias mutt='neomutt'
alias gm='mw'

#black background
alias xpdf='xpdf -rv'

alias :e="$EDITOR"
alias :q=exit
alias wleech='wget -r -np -nc'
alias ccm64='sudo ccm64'

alias dc='docker-compose'
