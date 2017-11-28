#!/usr/bin/env perl
#
# This script listen to ACPI events and acts accordingly.
# Written by fnux. I want to be able to mute my laptop even if it's locked !

use warnings;
use strict;

use IO::Socket::UNIX;
use Switch;

my $ACPID_SOCK = "/var/run/acpid.socket";

sub print_help() {
  print "Usage : ./acpi-handler.pl [opts]
  Options :
  * -h : help message
  * -d : daemonize\n";
}

sub daemonize() {
  use Proc::Daemon;
  Proc::Daemon::Init;
  main();
}

sub main() {
  my $stream = IO::Socket::UNIX->new(
    Type => SOCK_STREAM(),
    Peer => $ACPID_SOCK,
  );

  my $line;
  while ($line = <$stream>) {
    my ($type, $code) = ($line =~ m/^(\S*) (\S*)/);

    print "New event : $code. \n";
    switch($code) {
      case "MUTE"  { system "pavolume toggle &> /dev/null" }
      case "VOLDN" { system "pavolume -10% &> /dev/null" }
      case "VOLUP" { system "pavolume +10% &> /dev/null" }
      case "F20"   { system "pactl set-source-mute 1 toggle &> /dev/null" }
      case "BRTDN" { system "brightnessctl set 10%- &> /dev/null" }
      case "BRTUP" { system "brightnessctl set 10%+ &> /dev/null" }
      case "WLAN"  { system "notify-send -u normal 'ACPI Handler' 'WLAN RFKILL toggle' &> /dev/null" }
      # FIXME: should handle plugged in and out as separate messages
      case "ACPI0003:00" { system "notify-send -u critical 'Power Management' 'AC ADAPTER toggle' &> /dev/null"}
      else  {
        print "! -> Not handled. \n"
      }
    }
  }
}

my $arg = shift(@ARGV);
switch($arg) {
  case "-h"  { print_help() }
  case "-d"  { daemonize() }
  case undef { main() }
  else {
    print_help()
  }
}
