#include "zpuino.h"
#include "zpuino-types.h"
/* Most stuff is in zpuino-accel.S */

#define ZPUINO_MAX_INTERRUPTS 16

typedef void(*interrupt_type_t)(void) interrupt_type_t;

static interrupt_type_t itable[ZPUINO_MAX_INTERRUPTS]={0};

void attachInterrupt(uint8_t line, void (*function)(void), int mode)
{
	if (line>=ZPUINO_MAX_INTERRUPTS)
		return;
	// cli();
	itable[line] = function;
	// sei();
}
void detachInterrupt(uint8_t line)
{
	// cli();
	itable[line] = 0;
	// sei();
}

void _zpu_interrupt(uint8_t line)
{
	if (line>=ZPUINO_MAX_INTERRUPTS)
		return;
	if (itable[line])
		itable[line]();
}
