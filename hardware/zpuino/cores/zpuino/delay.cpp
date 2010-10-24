#include <delay.h>

void delayCycles(unsigned int cycles)
{
	unsigned int next = TIMERTSC + cycles;
	while (TIMERTSC<next) {}
}
