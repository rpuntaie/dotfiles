#!/bin/sh
#
# Suspend dunst and lock, then resume dunst when unlocked.

pkill -u $USER -USR1 dunst
i3lock -n -i ~/Pictures/wallpaper.png -t
pkill -u $USER -USR2 dunst
