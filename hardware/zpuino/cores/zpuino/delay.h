#ifndef __DELAY_H__
#define __DELAY_H__

#include <zpuino.h>

void delayCycles(unsigned int cycles);
unsigned int millis(void);
unsigned int micros(void);

static inline void delayMicroseconds(const unsigned int us) {
	delayCycles( clocksPerMicrosecond * us );
}

static inline void delay(const unsigned int ms) {
    delayCycles( clocksPerMilisecond * ms );
}

#endif
