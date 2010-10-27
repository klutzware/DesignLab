#include <delay.h>

void delayCycles(unsigned int cycles)
{
	unsigned int next = TIMERTSC + cycles;
	while (TIMERTSC<next) {}
}

unsigned int millis(void) {
    return TIMERTSC / clocksPerMilisecond;
}
unsigned int micros(void) {
    return TIMERTSC / clocksPerMicrosecond;
}
