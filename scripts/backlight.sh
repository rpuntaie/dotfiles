#!/bin/sh

max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
actual_brightness=$(cat /sys/class/backlight/intel_backlight/actual_brightness)
percentage=$(bc <<< "scale = 2; ($actual_brightness/$max_brightness) * 100")

notify-send -u low "Current Brightness : $percentage%"
