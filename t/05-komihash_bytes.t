use strict;
use warnings;
use utf8;
use Test::More;
use Crypt::Komihash qw(komihash);

my $binary = pack('C*', 0x00, 0x80, 0xff, 0x01, 0xfe, 0x7f);
is(
	sprintf('%016x', komihash($binary, 0)),
	'0e218bc6ab228bbd',
	'hashes high-bit binary data',
);

my $embedded_nuls = "\0abc\0def";
is(
	sprintf('%016x', komihash($embedded_nuls, 0)),
	'e4400fab962f8aba',
	'hashes embedded NUL bytes',
);

my $high_bytes = pack('C*', 0xff, 0xfe, 0xfd, 0x80, 0x81, 0x82);
is(
	sprintf('%016x', komihash($high_bytes, 0)),
	'6baf30a9eb9fd82e',
	'hashes consecutive high-bit bytes',
);

my $unicode = "caf\x{e9}";
my $latin1  = pack('C*', 0x63, 0x61, 0x66, 0xe9);
is(
	komihash($unicode, 0),
	komihash($latin1, 0),
	'converts representable Unicode characters to their byte values',
);

done_testing();
