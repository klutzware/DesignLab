#include "HardwareSerial.h"

HardwareSerial Serial(1); /* 1st slot */

void HardwareSerial::begin_slow(const unsigned int baudrate) {
	REGISTER(IO_SLOT(base),1) = BAUDRATEGEN(baudrate)|BIT(UARTEN);
}

int HardwareSerial::available()  {
	return (REGISTER(IO_SLOT(base),1) & 1);
}

int HardwareSerial::read()  {
	return REGISTER(IO_SLOT(base),0);
}

void HardwareSerial::write(unsigned char c) {
	while ((REGISTER(IO_SLOT(base),1) & 2)==2);
	REGISTER(IO_SLOT(base),0) = c;
}

