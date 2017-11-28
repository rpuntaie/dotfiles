#!/usr/bin/ruby
#
# Prints the network interfaces and their IP.
# Used in my status bar.

@ignored_interfaces = ["virbr0", "lo"]

input = %x(ip -o -4 addr)
regex = /^\d:\s(\w+)\s+inet\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\/\d{1,2}\s.*$/
Interface = Struct.new(:device, :addr)
interfaces = Array.new

input.each_line do |l|
  match = l.match(regex).captures
  unless @ignored_interfaces.include?(match[0])
    interfaces.push Interface.new(match[0], match[1])
  end
end

if interfaces.empty?
  print "Network Unavailable"
else
  interfaces.each_with_index do |e, i|
    print "#{e.device} #{e.addr}"
    print " " unless i == (interfaces.length - 1)
  end
end
