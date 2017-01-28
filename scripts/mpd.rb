#!/usr/bin/env ruby

require 'ruby-mpd'

# Connect to local MPD
mpd = MPD.new 'localhost', 6600
mpd.connect

song = mpd.current_song
system "notify-send -u normal 'Music Player Daemon - Playing' '#{song.artist} - #{song.title}'"

mpd.disconnect
