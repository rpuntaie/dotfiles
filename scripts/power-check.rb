#!/usr/bin/env ruby

# AC
powerSupply = File.new("/sys/class/power_supply/BAT0/subsystem/AC/online", "r").gets.to_i

# BAT0
bat0Full = File.new("/sys/class/power_supply/BAT0/energy_full", "r").gets.to_i
bat0Now = File.new("/sys/class/power_supply/BAT0/energy_now", "r").gets.to_i
bat0Inst = File.new("/sys/class/power_supply/BAT0/power_now", "r").gets.to_i

#BAT1
bat1Full = File.new("/sys/class/power_supply/BAT1/energy_full", "r").gets.to_i
bat1Now = File.new("/sys/class/power_supply/BAT1/energy_now", "r").gets.to_i
bat1Inst = File.new("/sys/class/power_supply/BAT1/power_now", "r").gets.to_i

# Computations
powerFull = bat0Full + bat1Full
powerNow = bat0Now + bat1Now
percentage = (powerNow.to_f / powerFull.to_f) * 100

instUsage = (bat0Inst + bat1Inst) / 1000.0**2

if powerSupply != 0
  powerSupplyText = "online"
else
end

if powerSupply != 0
  powerSupplyText = "online"
  level = "low"
elsif percentage < 20
  level = "critical"
  powerSupplyText = "offline"
else
  level = "normal"
  powerSupplyText = "offline"
end

system "
  notify-send -u #{level} '
  Actual State : #{percentage.to_i}%
  Instantaneous : #{instUsage}W
  Power Supply : #{powerSupplyText}
  '
"
