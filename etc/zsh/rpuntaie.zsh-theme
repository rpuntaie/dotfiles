#based on http://aperiodic.net/phil/prompt/

function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.
    
    PR_FILLBAR=""
    PR_PWDLEN=""
    
    local promptsize=${#${(%):-(%n@%m:%l)--(%D{%Y%m%d %H:%M})--()}} #PS1
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
    local C0=$PR_NO_COLOUR
    local C1=$PR_CYAN
    local C2=$PR_GREEN
    local C3=$PR_LIGHT_RED
    local C4=$PR_MAGENTA
    local C5=$PR_YELLOW

    PS1='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$C1($C2%(!.%SROOT%s.%n)$C2@%m:%l$C1)\
$PR_SHIFT_IN$PR_HBAR$PR_HBAR$PR_SHIFT_OUT\
($C5%D{%Y%m%d %H:%M}$C1)\
$PR_SHIFT_IN$PR_HBAR${(e)PR_FILLBAR}$PR_HBAR$PR_SHIFT_OUT\
(%(!.$C3.$C4)%$PR_PWDLEN<...<%~%<<$C1)\

% $C0'

    RPS1='%(?..$C3(%?%))$C1(${(e)$(battery_pct_prompt)}$C1)$(git_prompt_info)$(svn_prompt_info)$(hg_prompt_info)$C0'
    PS2=''
    RPS2='$C1($C2%_$C1)$C0 '


    ZSH_THEME_GIT_PROMPT_PREFIX="$C1(%(!.$C3.$C4)git:"
    ZSH_THEME_GIT_PROMPT_SUFFIX="$C1)"

    ZSH_THEME_SVN_PROMPT_PREFIX="$C1(%(!.$C3.$C4)svn:"
    ZSH_THEME_SVN_PROMPT_SUFFIX="$C1)"

    ZSH_THEME_HG_PROMPT_PREFIX="$C1(%(!.$C3.$C4)hg:"
    ZSH_THEME_HG_PROMPT_SUFFIX="$C1)"

}

setprompt
