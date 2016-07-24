#!/usr/bin/env ruby

# BAT0
bat0Full = File.new("/sys/class/power_supply/BAT0/energy_full", "r").gets.to_i
bat0Now = File.new("/sys/class/power_supply/BAT0/energy_now", "r").gets.to_i
bat0Inst = File.new("/sys/class/power_supply/BAT0/power_now", "r").gets.to_i

#BAT1
bat1Full = File.new("/sys/class/power_supply/BAT1/energy_full", "r").gets.to_i
bat1Now = File.new("/sys/class/power_supply/BAT1/energy_now", "r").gets.to_i
bat1Inst = File.new("/sys/class/power_supply/BAT1/power_now", "r").gets.to_i

powerFull = bat0Full + bat1Full
powerNow = bat0Now + bat0Now
percentage = (powerNow.to_f / powerFull.to_f) * 100

instUsage = (bat0Inst + bat1Inst) / 1000.0**2

if percentage < 20
  level = "critical"
else
  level = "normal"
end

system "
  notify-send -u #{level} '
  Actual power state : #{percentage.to_i}%
  Instantaneous : #{instUsage}W
  '
"
