#include "zpuino.h"
#include "zpuino-types.h"
#include "HardwareSerial.h"
/* Most stuff is in zpuino-accel.S */

#define ZPUINO_MAX_INTERRUPTS 16

typedef void(*interrupt_type_t)(void);

static interrupt_type_t itable[ZPUINO_MAX_INTERRUPTS]={0};

void attachInterrupt(unsigned int line, void (*function)(void), int mode)
{
	if (line>=ZPUINO_MAX_INTERRUPTS)
		return;
	// cli();
	itable[line] = function;
	// sei();
}
void detachInterrupt(unsigned int line)
{
	// cli();
	if (line>=ZPUINO_MAX_INTERRUPTS)
		return;
	itable[line] = 0;
	// sei();
}

void _zpu_interrupt(unsigned int line)
{
	if (line>=ZPUINO_MAX_INTERRUPTS)
		return;
	if (itable[line])
		itable[line]();
}
