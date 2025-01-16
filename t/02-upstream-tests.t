use strict;
use warnings;
use Test::More;
use Crypt::Komihash qw(komihash_hex komihash);

no warnings 'portable';

my @lines = get_data();

my $seed = 99;
foreach my $l (@lines) {
	if ($l =~ /UseSeed = (.+?):/) {
		my $seed_hex = $1;
		$seed        = hex($seed_hex);
	} elsif ($l =~ /"(.+?)" = (.+?)$/) {
		my $input    = $1;
		my $hex_hash = $2;

		$hex_hash =~ s/^0x//g;

		my $calc_hex = komihash_hex($input, $seed);

		#print "$input -> $hex_hash\n";
		is($calc_hex, $hex_hash, "$input (Seed:$seed)");
	}
}

done_testing();

#############################################################

sub trim {
	my ($s) = (@_, $_); # Passed in var, or default to $_
	if (!defined($s) || length($s) == 0) { return ""; }
	$s =~ s/^\s*//;
	$s =~ s/\s*$//;

	return $s;
}

sub get_data {
	my @ret;

	while (my $line = readline(DATA)) {
		$line = trim($line);

		if ($line) {
			push(@ret, $line);
		}
	}

	return @ret;
}

__DATA__

komihash UseSeed = 0x0000000000000000:
"This is a 32-byte testing string" = 0x05ad960802903a9d
"The cat is out of the bag" = 0xd15723521d3c37b1
"A 16-byte string" = 0x467caa28ea3da7a6
"The new string" = 0xf18e67bc90c43233
"7 chars" = 0x2c514f6e5dcb11cb

komihash UseSeed = 0x0123456789abcdef:
"This is a 32-byte testing string" = 0x6ce66a2e8d4979a5
"The cat is out of the bag" = 0x5b1da0b43545d196
"A 16-byte string" = 0x26af914213d0c915
"The new string" = 0x62d9ca1b73250cb5
"7 chars" = 0x90ab7c9f831cd940

komihash UseSeed = 0x0000000000000100:
"This is a 32-byte testing string" = 0x5f197b30bcec1e45
"The cat is out of the bag" = 0xa761280322bb7698
"A 16-byte string" = 0x11c31ccabaa524f1
"The new string" = 0x3a43b7f58281c229
"7 chars" = 0xcff90b0466b7e3a2
