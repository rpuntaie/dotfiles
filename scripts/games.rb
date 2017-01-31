#!/usr/bin/env ruby

require "curses"
require 'optparse'

DEFAULT_CONFIG = "#{Dir.home}/.local/opt/games/launcher"

def draw_title(win, width, title)
  x = (Curses.lines - title.length) / 2
  win.setpos(0, x)
  win.attrset(Curses::A_BOLD)
  win.addstr(title)
end

def draw_menu(win, lines, curr)
  curr_min = 1
  curr_max = lines.length
  curr = if curr < curr_min
           curr_max
         elsif curr > curr_max
           curr_min
         else
           curr
         end

  i = 1
  lines.each do |line|
    if i == curr
      win.attrset(Curses::A_STANDOUT)
    end
    win.setpos(i, 1)
    win.addstr(line)
    i += 1
    win.attroff(Curses::A_STANDOUT)
  end
  curr
end

def draw_command(win, map, curr)
  keys = map.keys
  key = keys.at(curr - 1)
  command = map[key]

  x = 20
  y = keys.length / 2 + 1
  win.setpos(y,x)
  win.attrset(Curses::A_DIM)
  str = "-> " + command
  win.addstr(str)
end

options = {}

# Parse arguments
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: lambda.rb [options]"

  options[:config] = DEFAULT_CONFIG
  opts.on('-c', '--config CONFIG', 'Specify config path') do |config|
    options[:config] = config
  end

  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end
end
optparse.parse!

# Get content
map = Hash.new

File.open(options[:config], "r").each_line do |line|
  split = line.split(";; ", 2)
  key = split.first
  value = split.last
  map[key] = value
end

# Draw

Curses.init_screen

height, width = Curses.lines, Curses.cols
top, left = 0, 0

top_win = Curses::Window.new(height, width, top, left)
top_win.refresh

win = top_win.subwin(height - 4, width - 4, top + 2, left + 2)
win.keypad(true)

# Fetch content
lines = map.keys

# Draw content
draw_title(win, width, "Launcher")

curr = 1 # current menu position, default is 1
draw_menu(win, lines, curr)
draw_command(win, map, curr)

# Main loop
loop do
  key = win.getch
  #win.clear

  case key
  when "q", 27 # 27 is Esc
    break
  when Curses::KEY_UP, "k"
    curr -= 1
    draw_title(win, width, "Launcher")
    curr = draw_menu(win, lines, curr)
    draw_command(win, map, curr)
    win.refresh
  when Curses::KEY_DOWN, "j"
    curr += 1
    draw_title(win, width, "Launcher")
    curr = draw_menu(win, lines, curr)
    draw_command(win, map, curr)
    win.refresh
  when Curses::KEY_ENTER, Curses::KEY_RIGHT, "l"
    key = lines.at(curr - 1)
    command = map[key]
    win.clear
    win.refresh
    win.close
    system("reset")
    system(command)
    exit
  else
    :noop
  end
end

win.close
