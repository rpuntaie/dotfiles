# vim: syntax=zsh
#based on http://aperiodic.net/phil/prompt/
#PS1 lines must fit

function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))

    ###
    # Truncate the path if it's too long.
    PR_FILLBAR=""
    PR_PWDLEN=""
    local promptsize=${#${(%):-%L(%n@%m:%l)--(%D{%Y%m%d %H:%M})--()}} #PS1
    local pwdsize=${#${(%):-%~}}
    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
        ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
        PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
    fi
}


setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
        local CMD=${1[(wr)^(*=*|sudo|-*)]}
        echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {
    ###
    # Need this so the prompt will work.

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
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}

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
    PS1='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_MAGENTA%L($PR_GREEN%(!.%SROOT%s.%n)$PR_GREEN@%m:%l$PR_MAGENTA)\
$PR_SHIFT_IN$PR_HBAR$PR_HBAR$PR_SHIFT_OUT\
($PR_YELLOW%D{%Y%m%d %H:%M}$PR_MAGENTA)\
$PR_SHIFT_IN$PR_HBAR${(e)PR_FILLBAR}$PR_HBAR$PR_SHIFT_OUT\
(%(!.$PR_LIGHT_RED.$PR_WHITE)%$PR_PWDLEN<...<%~%<<$PR_MAGENTA)\

% $PR_NO_COLOUR'

    #GITSUPER: RPS1='%j$(vi_mode_prompt_info)%(?..$PR_LIGHT_RED(%?%))$PR_MAGENTA(${(e)$(battery_pct_prompt)}$PR_MAGENTA)$(git_prompt_info)$(svn_prompt_info)$(hg_prompt_info)$PR_NO_COLOUR'
    RPS1='$(vi_mode_prompt_info)%(?..$PR_LIGHT_RED(%?%))%j$PR_MAGENTA(${(e)$(battery_pct_prompt)}$PR_MAGENTA)$(git_super_status)$(svn_prompt_info)$(hg_prompt_info)$PR_NO_COLOUR'

    PS2=''
    RPS2='$PR_MAGENTA($PR_GREEN%_$PR_MAGENTA)$PR_NO_COLOUR '

    #GITSUPER: ZSH_THEME_GIT_PROMPT_PREFIX="$PR_MAGENTA(%(!.$PR_LIGHT_RED.$PR_WHITE)git:"
    #GITSUPER: ZSH_THEME_GIT_PROMPT_SUFFIX="$PR_MAGENTA)"

    ZSH_THEME_SVN_PROMPT_PREFIX="$PR_MAGENTA(%(!.$PR_LIGHT_RED.$PR_WHITE)svn:"
    ZSH_THEME_SVN_PROMPT_SUFFIX="$PR_MAGENTA)"

    ZSH_THEME_HG_PROMPT_PREFIX="$PR_MAGENTA(%(!.$PR_LIGHT_RED.$PR_WHITE)hg:"
    ZSH_THEME_HG_PROMPT_SUFFIX="$PR_MAGENTA)"

}

setprompt

