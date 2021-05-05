#!/usr/bin/env perl
use strict;
use warnings;

use 5.010; # say

my $hmltn = $ARGV[0] || die "No hamiltonian input";
my $tmpl = $ARGV[1] || die "No julia template";
my $out = "out.jl";
say "Hamiltonian input: $hmltn, julia template: $tmpl, output: $out";
my $array = "[";
my $dmnsn = 0;
open my $fh, "<$hmltn" or die "Failed to open $hmltn for reading: $!";
while(my $line = <$fh>) {
  $line =~ s/^\s+//;
  $line =~ s/\s+$//;
  $line =~ s/\s+/ /g;
  $dmnsn = split ' ', $line if !$dmnsn;
  $line =~ s/([0-9\.]+)/$1+0.0im/g;
  $array .= "$line\n";
}
close $fh;
chomp $array;
$array .= "]";
say "Array: $array";
say "Dimension: $dmnsn";
my $start = "[";
for(my $i = 0; $i < $dmnsn; ++$i) {
  for(my $i = 0; $i < $dmnsn; ++$i) {
    if($start eq "[") {
      $start .= "1.0+0.0im ";
      next;
    }
    $start .= "0.0+0.0im ";
  }
  $start =~ s/ $//;
  $start .= "\n";
}
chomp $start;
$start .= "]";
say "Start: $start";

open $fh, "<$tmpl" or die "Failed to open $tmpl for reading: $!";
open my $fout, ">$out" or die "Failed to open $out for writing: $!";
while(my $line = <$fh>) {
  $line =~ s/<HAMILTONIAN>/$array/;
  $line =~ s/<START>/$start/;
  print $fout $line;
}
close $fout;
close $fh;
system "julia -i $out";
