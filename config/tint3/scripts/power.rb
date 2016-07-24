#!/usr/bin/env ruby
# Power-related stuff

# GPU Check
input = %x(cat /proc/acpi/bbswitch)
if input.split(' ')[1].chomp == "ON"
  print "GPU ON"
else
  ""
end

# Power consuption
bat0 = File.new("/sys/class/power_supply/BAT0/power_now", "r").gets.to_i
bat1 = File.new("/sys/class/power_supply/BAT1/power_now", "r").gets.to_i
usage = (bat0 + bat1) / 1000.0**2
print "#{usage}W"

print "\n"
