# Interactive shell aliases

#colors set via X11/Xresources
#alias urxvt='urxvt -bg black -fg white'
#alias xterm='xterm -fa monaco -fs 10 -bg black -fg white'

alias onchange='git ls-files | entr bash -c '
alias r='ranger'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'
alias la='ls -lAh'
alias ll='ls -lh -tr'
alias lsd='ls -d'
alias lt='ls -tr'
alias ltt='ls -tr | tail -n 1'
alias ol='chromium "$( lt | tail -n 1)"'
alias c='chromium'
alias o='open'
alias dc='docker-compose'
alias t='mpv'
alias rm=trash
#~/.local/share/Trash/
#command rm # for real rm

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
alias glga="git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(authorname) %(refname:short)'"
#grt to go to git root
alias ..g='git rev-parse --show-toplevel'
alias glr='git pull --recurse-submodules'
alias ghash='git rev-parse HEAD'
alias gdst='git diff stash@{0} HEAD'
alias gu='git ls-files -o'
alias gurm='git clean -Xdf'


#. <name>/bin/activate and deactivate to exit
alias venv='python -m venv --system-site-packages --symlinks'
alias pyv='source $PYVHOME/bin/activate' # this is automatic via mise now
alias pyo='PYTHON_BASIC_REPL=1 python'

alias xtex='xelatex -interaction=nonstopmode'

alias sp='sudo pacman'
alias spsyu='sudo pacman -Sy; sudo pacman -S archlinux-keyring; sudo pacman -Su'

alias mutt='neomutt'
alias gm='mw'

#black background
alias xpdf='xpdf -rv'

alias :e="$EDITOR"
alias :q=exit
alias wleech='wget -r -np -nc'
alias ccm64='sudo -E ccm64'

alias androidemu='emulator -avd $(emulator -list-avds)'

alias clndr='python -m calendar'

alias fh='find . -iname'
alias ishdd='lsblk -o NAME,ROTA'

export IDF_PATH=$HOME/msrc/esp-idf
alias espidf='export IDF_PATH=$HOME/msrc/esp-idf;
. $IDF_PATH/export.sh'

if command -v brew; then
alias vim="$(brew --prefix vim)/bin/vim"
fi

alias blender=$HOME/msrc/blender-git/build_linux/bin/blender
export BLENDER_SYSTEM_SCRIPTS=$HOME/msrc/blender-git/blender/scripts
export BLENDER_USER_CONFIG=$HOME/msrc/blender-git/blender/config

# scp1 110 x.y
scp1(){
  scp $2 roland@192.168.1.$1:/home/roland/tmp/
}

alias b0='bluetoothctl disconnect'
alias bs='bluetoothctl scan on'
alias b1='bluetoothctl connect F4:4E:FC:A6:B7:49'
alias b2='bluetoothctl connect 5C:FB:7C:E1:0D:D5'

alias j='firejail --noprofile --net=none'

alias gotestcompile='go test -gcflags '-N -l' -c'

alias zipmount='fuse-zip -o ro'
