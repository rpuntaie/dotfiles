# Interactive shell aliases

#colors set via X11/Xresources
#alias urxvt='urxvt -bg black -fg white'
#alias xterm='xterm -fa monaco -fs 10 -bg black -fg white'

# Generic aliases:
alias r='ranger'
alias cp='cp -i'
alias grep='grep --color=auto'
alias la='ls -lAh'
alias ll='ls -lh --time-style=long-iso'
alias ls='ls -A --color=auto --quoting-style=literal'
alias lt='ll -t'
alias mv='mv -i'

alias pipiu='pip install --user'
alias pipui='sudo pip uninstall'

#weather
alias wttr='curl wttr.in'
alias moon='curl wttr.in/Moon'

# Server only aliases (mostly additional safety):
if [ -n "$SSH_CONNECTION" ]; then
  alias rm='rm -i'
fi

# Random other aliases:
alias cc='gcc -std=c11 -pedantic -Wall -Wextra -Wbad-function-cast -Wcast-align -Wcast-qual -Wconversion -Wfloat-equal -Wformat=2 -Wlogical-op -Wmissing-declarations -Wmissing-prototypes -Wpointer-arith -Wshadow -Wstrict-prototypes -Wwrite-strings'
alias poscc='gcc -std=c11 -pedantic -Wall -Wextra'

alias ax='git annex'

#. <name>/bin/activate and deactivate to exit
alias venv='python -m venv --system-site-packages --symlinks'

alias xtex='xelatex -interaction=nonstopmode'

alias spac='sudo pacman -S'

alias :e="$EDITOR"
alias :q=exit

#background open and disown
function open () {
    xdg-open "$*" &!
}
