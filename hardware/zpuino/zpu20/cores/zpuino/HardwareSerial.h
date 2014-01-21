#ifndef __HardwareSerial_h__
#define __HardwareSerial_h__

#include "zstdio.h"

#include <zpuino.h>
#include <zpuino-types.h>
#include "Stream.h"
#include "Print.h"
#include "BaseDevice.h"
#include "zfdevice.h"

#define VENDOR_ZPUINO       0x08
#define PRODUCT_ZPUINO_UART 0x11

namespace ZPUino {
};

#ifdef HAVE_ZFDEVICE
int serial_register_device(const char *name, void*data);
#endif

class HardwareSerial: public ZPUino::BaseDevice, public Stream
{
private:
public:
	HardwareSerial(uint8_t instance=0xff): BaseDevice(instance) {}

	__attribute__((always_inline)) inline void begin(const unsigned int baudrate) {
		if (deviceBegin(VENDOR_ZPUINO, PRODUCT_ZPUINO_UART)==0) {
			if (__builtin_constant_p(baudrate)) {
				REG(1) = BAUDRATEGEN(baudrate) | BIT(UARTEN);
			} else {
				begin_slow(baudrate);
                        }
#ifdef HAVE_ZFDEVICE
                        if (getInstance()!=0xff) {
                            /* Register it */
                            char name[16];
                            sprintf(name,"serial%d",getInstance());
                            serial_register_device(name,this);
                        }
#endif
		}
	}
	void begin_slow(const unsigned int baudrate);

	int available(void) {
		return (REG(1) & 1);
	}

	virtual int read(void) {
		return REG(0);
	}

	virtual void flush(void);

	size_t write(uint8_t c);

	virtual int peek() { return -1; }

	using Print::write; // pull in write(str) and write(buf, size) from Print
private:
	unsigned int ioslot;
};

extern void serialEventRun(void) __attribute__((weak));

extern HardwareSerial Serial; /* 1st slot */
extern HardwareSerial Serial1; /* 2nd slot */

#endif
