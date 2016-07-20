#!/usr/bin/env ruby

##############
# Monitoring #
##############

# Load Average
lavg = File.new("/proc/loadavg").gets
print lavg.split[0]

print " // "

# Disk Usage
VOLUMES = ["/dev/mapper/LVM0-rootvol","/dev/mapper/LVM0-homevol"]

for v in VOLUMES
  print `df #{v}`.split[11] + " "
end

print "// "

# Network
input= %x(ip -o -4 addr)
data_array = Array.new
input.each_line { |l| data_array.push(l) }
data_array.delete_at(0)

if data_array.length > 0
    data_array.each do |line|
        parsed = line.split(' ')
        print parsed[1] + " "
        print parsed[3].split('/')[0] + " "
    end
else
    print "Network Unavailable "
end

#########
# Power #
#########

print "// "

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
