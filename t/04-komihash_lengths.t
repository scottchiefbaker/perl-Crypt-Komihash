use strict;
use warnings;
use Test::More;
use Crypt::Komihash qw(komihash);

# creates a byte string containing the values 0 through $length - 1, wrapping every 256 values.
# example: 00 01 02 ...
sub bytes {
	my ($length) = @_;
	return '' if $length == 0;

	return pack('C*', map { $_ % 256 } 0 .. $length - 1);
}

is(sprintf('%016x', komihash(bytes(0)  , 0)), 'b7683ea7430132b4', 'length 0');
is(sprintf('%016x', komihash(bytes(1)  , 0)), 'd5b6bb48fef4dfe0', 'length 1');
is(sprintf('%016x', komihash(bytes(2)  , 0)), '960631f178b2ad49', 'length 2');
is(sprintf('%016x', komihash(bytes(3)  , 0)), '7a9717e9eea4be8b', 'length 3');
is(sprintf('%016x', komihash(bytes(4)  , 0)), 'd38be68fefe5a079', 'length 4');
is(sprintf('%016x', komihash(bytes(7)  , 0)), '5b00a65f9e31ee4a', 'length 7');
is(sprintf('%016x', komihash(bytes(8)  , 0)), '00b4313a24431306', 'length 8');
is(sprintf('%016x', komihash(bytes(11) , 0)), 'dd6fd66711db7132', 'length 11');
is(sprintf('%016x', komihash(bytes(12) , 0)), '64c2ad96013f70fe', 'length 12');
is(sprintf('%016x', komihash(bytes(15) , 0)), 'bd957f28d607aa23', 'length 15');
is(sprintf('%016x', komihash(bytes(16) , 0)), '97c39f940688b201', 'length 16');
is(sprintf('%016x', komihash(bytes(31) , 0)), 'c77e02ed4b201b9a', 'length 31');
is(sprintf('%016x', komihash(bytes(32) , 0)), '256d74350303a1ba', 'length 32');
is(sprintf('%016x', komihash(bytes(63) , 0)), '978ec2ba1667d4d5', 'length 63');
is(sprintf('%016x', komihash(bytes(64) , 0)), '90b07e2158f88cc0', 'length 64');
is(sprintf('%016x', komihash(bytes(65) , 0)), 'f345f72e78881b16', 'length 65');
is(sprintf('%016x', komihash(bytes(128), 0)), '52d3103a8f82a5f7', 'length 128');
is(sprintf('%016x', komihash(bytes(768), 0)), '53381db9fd240086', 'length 768');
is(sprintf('%016x', komihash(bytes(769), 0)), '1ae073ced4eacf09', 'length 769');

done_testing();
