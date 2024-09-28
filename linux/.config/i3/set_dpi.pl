#!/usr/bin/perl

use strict;
use warnings;

my @xrandr_output = `xrandr`;
foreach my $line (@xrandr_output) {
	if ($line !~ /(\S+) connected/) {
	  next;
	};
	my $display = $1;
	my $is_laptop_screen = ($display eq 'eDP-1');
	if (!$is_laptop_screen) {
        next;
    };
    system("xrandr --output eDP-1 --dpi 120");
}
