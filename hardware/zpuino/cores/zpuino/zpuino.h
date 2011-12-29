#ifndef __ZPUINO_H__
#define __ZPUINO_H__

#include "register.h"
#include "interrupt.h"

#define __ZPUINO__ 1

typedef volatile unsigned int* register_t;

extern void itoa(int value, char *dest, int base);
extern void utoa(unsigned int value, char *dest, int base);
extern char *ultoa ( unsigned long value, char * str, int base );
extern char *ltoa (long value, char * str, int base );

extern "C" void pinMode(unsigned int pin, int mode);
extern "C" void digitalWrite(unsigned int pin, int value);
extern "C" void pinModePPS(unsigned int pin, int value);

static inline __attribute__((always_inline)) register_t outputRegisterForPin(unsigned int pin)
{
	return &GPIODATA(pin/32);
}

static inline __attribute__((always_inline)) register_t inputRegisterForPin(unsigned int pin)
{
	return &GPIODATA(pin/32);
}

static inline __attribute__((always_inline)) register_t modeRegisterForPin(unsigned int pin)
{
	return &GPIOTRIS(pin/32);
}

static inline __attribute__((always_inline)) register_t PPSmodeRegisterForPin(unsigned int pin)
{
	return &GPIOPPSMODE(pin/32);
}

static inline __attribute__((always_inline)) unsigned int bitMaskForPin(unsigned int pin)
{
    return (1<<(pin%32));
}

static inline __attribute__((always_inline)) int digitalRead(unsigned int pin)
{
	return !!(*inputRegisterForPin(pin) & bitMaskForPin(pin));
}

static inline void __attribute__((always_inline)) outputPinForFunction(unsigned int pin,unsigned int function)
{
	GPIOPPSOUT(pin)=function;
}

static inline void __attribute__((always_inline)) inputPinForFunction(unsigned int pin,unsigned int function)
{
	GPIOPPSIN(function)=pin;
}

#endif
