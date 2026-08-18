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
		12297829382473034410,
		18446744073709551614,
		5270498306774157584,
		13469051228422846976,
	],
	'sequence for seeds 0, 0',
);

komirand_seed(1, 1);
@arr = get_random_array(4);
is_deeply(
	\@arr,
	[
		12297829382473034410,
		2635249153387078805,
		2342443691899625615,
		2167172538662824057,
	],
	'sequence for seeds 1, 1',
);

komirand_seed(81985529216486895, 18364758544493064720);
@arr = get_random_array(4);
is_deeply(
	\@arr,
	[
		9844736621421215500,
		15727883774196923382,
		10014643065400623294,
		161097823486038685,
	],
	'sequence for mixed seeds',
);

komirand_seed(18446744073709551615, 18446744073709551615);
@arr = get_random_array(4);
is_deeply(
	\@arr,
	[
		12297829382473034406,
		5270498306774157656,
		4099276460824345332,
		15739296313380375995,
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
