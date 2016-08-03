#!/usr/bin/env ruby
# System-related stuff

# Load Average
lavg = File.new("/proc/loadavg").gets
print lavg.split[0]

print " // "

# Disk Usage
VOLUMES = ["/dev/mapper/vg0-root","/dev/mapper/vg0-home"]

i = 1
for v in VOLUMES
  print `df #{v}`.split[11]
  print " " if i < VOLUMES.size()
  i += 1
end


