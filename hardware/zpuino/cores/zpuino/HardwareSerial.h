#include <zpuino.h>
#include <zpuino-types.h>
#include "Stream.h"

class HardwareSerial: public Stream
{
private:
public:
	HardwareSerial(unsigned int b): base(b) {}

	__attribute__((always_inline)) inline void begin(const unsigned int baudrate) {
		if (__builtin_constant_p(baudrate)) {
			REGISTER(IO_SLOT(base),1) = BAUDRATEGEN(baudrate) | BIT(UARTEN);
		} else {
			begin_slow(baudrate);
		}
	}
	void begin_slow(const unsigned int baudrate);

	virtual int available(void);

	virtual int read(void);

	virtual void flush(void) {};

	void write(uint8_t c);

	using Print::write; // pull in write(str) and write(buf, size) from Print
private:
    unsigned int base;
};


extern HardwareSerial Serial; /* 1st slot */

