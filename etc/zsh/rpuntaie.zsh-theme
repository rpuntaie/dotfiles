# vim: syntax=zsh

my_git_info() {
    __GIT_REMOTE="$(git remote get-url origin 2>/dev/null)"
    echo "$(git_super_status)%{$fg_bold[green]%}${__GIT_REMOTE#*//}%{${reset_color}%}"
}

setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
        local CMD=${1[(wr)^(*=*|sudo|-*)]}
        echo -n "\ek$CMD\e\\"
    fi
}


setopt prompt_subst

###
# See if we can use colors.

autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done
PR_NO_COLOUR="%{$terminfo[sgr0]%}"


###
# See if we can use extended characters to look nicer.
typeset -A altchar
set -A altchar ${(s..)terminfo[acsc]}
PR_SET_CHARSET="%{$terminfo[enacs]%}"

###
# Decide if we need to set titlebar text.
case $TERM in
    xterm*)
        PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
        ;;
    screen)
        PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
        ;;
    *)
        PR_TITLEBAR=''
        ;;
esac

###
# Decide whether to set a screen title
if [[ "$TERM" == "screen" ]]; then
    PR_STITLE=$'%{\ekzsh\e\\%}'
else
    PR_STITLE=''
fi

###
# Finally, the prompt.
NEWLINE=$'\n'
PS1='${NEWLINE}$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_MAGENTA%L($PR_RED%D{%Y%m%d %H:%M}$PR_MAGENTA)\
$(vi_mode_prompt_info)%(?..$PR_LIGHT_RED(%?%))%j$PR_MAGENTA(${(e)$(battery_pct_prompt)}$PR_MAGENTA)$(my_git_info):$PR_YELLOW%~\

% $PR_NO_COLOUR'
PS2=''

