#!/usr/bin/env ruby
# System-related stuff

# Load Average
lavg = File.new("/proc/loadavg").gets
print lavg.split[0]

print " // "

# Disk Usage
VOLUMES = ["/dev/mapper/LVM0-rootvol","/dev/mapper/LVM0-homevol"]

for v in VOLUMES
  print `df #{v}`.split[11] + " "
end


