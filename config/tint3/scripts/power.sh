#! /bin/sh

bat0=`cat /sys/class/power_supply/BAT0/power_now`
bat1=`cat /sys/class/power_supply/BAT1/power_now`
w="W"
let m=($bat0+$bat1)/1000/1000
echo $m$w
