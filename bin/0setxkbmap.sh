# switch between us, de layouts or the one provided
 
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
 
xmodmap $XMODMAP

exit 0
