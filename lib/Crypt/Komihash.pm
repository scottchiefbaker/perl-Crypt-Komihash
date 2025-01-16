package Crypt::Komihash;

use strict;
use warnings;
use base qw(Exporter);
require XSLoader;

our $VERSION = '0.01';

XSLoader::load('Crypt::Komihash', $VERSION);

our @EXPORT_OK = qw(komihash komihash_hex);

1;

__END__

=head1 NAME

Crypt::Komihash - Komihash implementation in Perl

=head1 SYNOPSIS

  use Crypt::Komihash qw(komihash komihash_hex);

  my $str  = "Hello world";
  my $seed = 0;

  my $num     = Crypt::Komihash::komihash($str, $seed);     # 3745467240760726046
  my $hex_str = Crypt::Komihash::komihash_hex($str, $seed); # 33fa929c7367d21e

=head1 DESCRIPTION

Komihash is a super fast modern hashing algorithm that converts strings into
64bit integers. Mainly designed for hash-table, hash-map, and bloom-filter
uses.

Komihash: https://github.com/avaneev/komihash

=head1 METHODS

=head2 B<my $str = komihash($str, $seed)>

returns 64bit integer hash for the given string and seed.

=head2 B<my $hex = komihash_hex($str, $seed)>

returns hex string hash for the given string and seed.

=head1 BUGS

Submit issues on Github: L<https://github.com/scottchiefbaker/perl-Crypt-Komihash/issues>

=head1 AUTHOR

Scott Baker - L<https://www.perturb.org/>
