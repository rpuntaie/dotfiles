#! /usr/bin/ruby
# Network-related stuff

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

