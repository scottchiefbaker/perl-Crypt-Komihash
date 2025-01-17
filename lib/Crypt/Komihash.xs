#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <ctype.h>
#include <string.h>
#include "komihash.h"

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

		sprintf(value64, "%016lx", (uint64_t) komihash(input, STRLEN_length_of_input, seed));
        RETVAL = value64;
    OUTPUT:
        RETVAL
