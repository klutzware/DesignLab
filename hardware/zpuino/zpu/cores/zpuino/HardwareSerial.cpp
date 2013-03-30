#include "HardwareSerial.h"

HardwareSerial Serial(1); /* 1st instance/slot */

#ifdef ZPU15

void HardwareSerial::begin_slow(const unsigned int baudrate) {
	REG(1) = BAUDRATEGEN(baudrate)|BIT(UARTEN);
}

void HardwareSerial::flush() {
	while (REG(1) & 4);
}

size_t HardwareSerial::write(unsigned char c) {
	while ((REG(1) & 2)==2);
	REG(0) = c;
	return 1;
}

#else

void HardwareSerial::begin_slow(const unsigned int baudrate) {
	 REGISTER(ioslot,1) = BAUDRATEGEN(baudrate)|BIT(UARTEN);
}

size_t HardwareSerial::write(unsigned char c) {
	while ((REGISTER(ioslot,1) & 2)==2);
	REGISTER(ioslot,0) = c;
}


#endif
