#! /usr/bin/ruby

input = %x(cat /proc/acpi/bbswitch)
if input.split(' ')[1].chomp == "ON"
    print "GPU ON //"
end
