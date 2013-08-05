#include "HardwareSerial.h"
#include <DeviceRegistry.h>

HardwareSerial Serial(1); /* 1st instance/slot */
HardwareSerial Serial1(2); /* 1st instance/slot */

using namespace ZPUino;

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

void HardwareSerial::setPins(TX tx, RX rx)
{
    pinMode(tx, OUTPUT);
    pinMode(rx, INPUT);
    pinModePPS(tx,HIGH);

    int ppspin = DeviceRegistry::getPPSOutputPin( getSlot(), 0 );
    outputPinForFunction( tx, ppspin );
    ppspin = DeviceRegistry::getPPSInputPin( getSlot(), 0 );
    inputPinForFunction( rx, ppspin );
}
