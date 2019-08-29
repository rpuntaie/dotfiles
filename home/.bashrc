# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $XDG_CONFIG_HOME/sh/interactive

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
