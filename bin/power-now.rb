#!/usr/bin/env ruby
#
# Written by Fnux.

require 'optparse'

@prefix = "/sys/class/power_supply/"

def print_usage()
  puts "Usage: ./power-now.rb OPTS"
  puts "       where --ac prints the status of the AC adapter"
  puts "       where --ac-with-sep prints the status of the AC adapter and a separator"
  puts "       where --bat prints the power drawed from the batteries"
end

def parse_opts()
  options = Hash.new
  options_parser = OptionParser.new do |opt|
    opt.on('--ac') { |o| options[:ac] = true}
    opt.on('--ac-with-sep') { |o| options[:ac] = true; options[:ac_separator] = true}
    opt.on('--bat') { |o| options[:batteries] = true}
  end

  # parse the arguments, exit if no or invalid arguments were provided
  begin
    options_parser.parse!
    raise "No argument provided !" if options.empty?
  rescue
    print_usage(); exit(1)
  end

  # return
  options
end

def main()
  options = parse_opts()
  supplies = Dir.entries(@prefix)
  output = String.new

  if options[:ac]
    # AC
    (puts "Unable to get AC status." ; exit(1)) unless supplies.include?("AC")
    is_ac_online = (File.new(@prefix + "AC" + "/online").gets.to_i == 1)

    output += (is_ac_online ? "AC" : String.new)
    if options[:ac_separator] && is_ac_online
      output += " / "
    end
  end

  if options[:batteries]
    # Batteries
    batteries = supplies.select { |supply| supply =~ /^BAT\d+$/}
    (puts "No battery detected."; exit(1)) if batteries.empty?

    batteries_power = batteries.collect do |battery|
      path = @prefix + battery + "/power_now"
      if File.exists?(path)
        File.new(path, "r").gets.to_i
      end
    end

    power_now = batteries_power.reduce(:+).to_i
    power_now_w = (power_now / 10.0**6).round(2)

    output += "#{power_now_w}W"
  end

  # return
  puts output
end

main()
