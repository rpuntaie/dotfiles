# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $XDG_CONFIG_HOME/sh/interactive

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local RCol='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'

    PS1+="${Gre}\u${RCol}${RCol}@${BBlu}\h ${Pur}\W"
    if [ $EXIT != 0 ]; then
        PS1+="${Red} >$EXIT${RCol}${BYel}$ ${RCol}"      # Add red if exit code non 0
    else
        PS1+="${Gre} >$EXIT${RCol}${BYel}$ ${RCol}"
    fi

}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"
