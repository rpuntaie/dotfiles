#!/usr/bin/env ruby

maxBrightness = File.open("/sys/class/backlight/intel_backlight/max_brightness", "r").gets.to_i
currentBrightness = File.open("/sys/class/backlight/intel_backlight/actual_brightness", "r").gets.to_i

percentage = (currentBrightness.to_f / maxBrightness.to_f) * 100

system "notify-send -u low 'Current Brightness : #{percentage.to_i}%'"
