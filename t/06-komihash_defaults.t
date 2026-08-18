use strict;
use warnings;
use Test::More;
use Crypt::Komihash qw(komihash komihash_hex);

my $input = 'Hello World';

is(
	komihash($input),
	komihash($input, 0),
	'komihash defaults to seed 0',
);

is(
	komihash_hex($input),
	komihash_hex($input, 0),
	'komihash_hex defaults to seed 0',
);

is(
	komihash_hex($input, undef),
	komihash_hex($input, 0),
	'komihash_hex treats an undefined seed as 0',
);

done_testing();
