#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <ctype.h>
#include <string.h>
#include <inttypes.h>
#include "komihash.h"
#include "rdtsc_rand.h"

// Global seeds used for komirand
uint64_t SEED1;
uint64_t SEED2;

bool has_been_seeded = false;

// External function allow setting the seeds
static void komirand_seed(uint64_t seed1, uint64_t seed2) {
	SEED1 = seed1;
	SEED2 = seed2;

	//printf("SEED: %llu / %llu\n", seed1, seed2);

	has_been_seeded = true;
}

static uint64_t komirand64() {
	if (!has_been_seeded) {
		komirand_seed(rdtsc_rand64(), rdtsc_rand64());
	}

	uint64_t ret = komirand(&SEED1, &SEED2);

	return ret;
}

// XS binding
MODULE = Crypt::Komihash   PACKAGE = Crypt::Komihash

UV komihash(const char *input, int length(input), UV seed = 0)
    CODE:
        RETVAL = (UV) komihash(input, STRLEN_length_of_input, seed);
    OUTPUT:
        RETVAL

char *komihash_hex(const char *input, int length(input), UV seed = 0)
    CODE:
		static char value64[17];

		// We use PRIx64 here for portability... 64bit hex number
		sprintf(value64, "%016" PRIx64, (uint64_t) komihash(input, STRLEN_length_of_input, seed));
        RETVAL = value64;
    OUTPUT:
        RETVAL

UV komirand64()

void komirand_seed(UV seed1, UV seed2)

UV rdtsc_rand64()

UV get_rdtsc()
