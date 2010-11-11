#include <zpuino.h>
#include <zpuino-types.h>

template<unsigned int iobase>
	class HardwareSerial
{
private:
public:
	HardwareSerial(){}

	__attribute__((always_inline)) static inline void begin(const unsigned int baudrate) {
		if (__builtin_constant_p(baudrate)) {
			REGISTER(IO_SLOT(iobase),1) = BAUDRATEGEN(baudrate);
		} else {
			begin_slow(baudrate);
		}
	}
	static void begin_slow(const unsigned int baudrate);

	int available(void) const;
	int peek(void) {};
	int read(void) const;
	void flush(void) {};
	void write(unsigned char c);
	void write(const char *c);
};


extern HardwareSerial<1> Serial; /* 1st slot */

template<unsigned int base>
void HardwareSerial<base>::begin_slow(const unsigned int baudrate) {
	REGISTER(IO_SLOT(base),1) = BAUDRATEGEN(baudrate);
}

template<unsigned int base>
int HardwareSerial<base>::available() const {
	return (REGISTER(IO_SLOT(base),1) & 1);
}

template<unsigned int base>
int HardwareSerial<base>::read() const {
	return REGISTER(IO_SLOT(base),0);
}

template<unsigned int base>
void HardwareSerial<base>::write(unsigned char c) {
	while ((REGISTER(IO_SLOT(base),1) & 2)==2);
	REGISTER(IO_SLOT(base),0) = c;
}

template<unsigned int base>
void HardwareSerial<base>::write(const char *c) {
	while (*c) {
		write(*c);
		c++;
	}
}
