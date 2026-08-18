use strict;
use warnings;
use Test::More;
use Crypt::Komihash qw(komirand_seed komirand64);

my @arr = ();

komirand_seed(0, 0);
@arr = get_random_array(4);
is_deeply(
	\@arr,
	[
		6148914691236517205,
		8784163844623596006,
		12635741381046153916,
		17209846627463883557,
	],
	'sequence for seeds 0, 0',
);

komirand_seed(1, 1);
@arr = get_random_array(4);
is_deeply(
	\@arr,
	[
		6148914691236517206,
		8784163844623596011,
		17038167548212231064,
		5666569824901869978,
	],
	'sequence for seeds 1, 1',
);

komirand_seed(81985529216486895, 18364758544493064720);
@arr = get_random_array(4);
is_deeply(
	\@arr,
	[
		8677442405813432583,
		8053850473847273283,
		15246035607542376175,
		3101200232176389048,
	],
	'sequence for mixed seeds',
);

komirand_seed(18446744073709551615, 18446744073709551615);
@arr = get_random_array(4);
is_deeply(
	\@arr,
	[
		6148914691236517204,
		11419412998010674818,
		10687364159785734489,
		16263213729877912817,
	],
	'sequence for all-ones seeds',
);

komirand_seed(0, 0);
my @first = get_random_array(4);
komirand_seed(0, 0);
my @repeat = get_random_array(4);

is_deeply(\@repeat, \@first, 're-seeding reproduces the sequence');

done_testing();

################################################################################
################################################################################

sub get_random_array {
	my $num = shift();
	my @ret = ();

	for (1 .. $num) {
		push(@ret, komirand64());
	}

	return @ret;
}
