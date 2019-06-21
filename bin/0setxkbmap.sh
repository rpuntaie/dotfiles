# switch between us, de layouts
 
# If an explicit layout is provided as an argument, use it. Otherwise, select the next layout from
# the set [us, de].
if [[ -n "$1" ]]; then
    setxkbmap $1
else
    layout=$(setxkbmap -query | grep layout | awk '{print $2}')
    case $layout in
        us)
            setxkbmap de
            ;;
        *)
            setxkbmap us
            ;;
    esac
fi
 
xmodmap ~/.Xmodmap

exit 0
