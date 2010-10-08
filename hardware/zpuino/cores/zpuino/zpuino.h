#include <register.h>


template<unsigned int base,unsigned int offset>
	struct Register8 {
		static void set(const unsigned char value);
		static unsigned char get();
	};

