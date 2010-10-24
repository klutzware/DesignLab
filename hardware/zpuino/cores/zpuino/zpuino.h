#ifndef __ZPUINO_H__
#define __ZPUINO_H__

#include "register.h"

const unsigned int clockFrequency = CLK_FREQ;
const unsigned int clocksPerMicrosecond = clockFrequency/1000000U;
const unsigned int clocksPerMilisecond = clockFrequency/1000U;

template<unsigned int pin>
	struct digitalUpS {
		static void apply() {
			GPIODATA( pin / 32 ) |= (1<<(pin%32));
		}
	};

static inline void digitalUp(const unsigned int pin)
{
	GPIODATA( pin / 32 ) |= (1<<(pin%32));
}

template<unsigned int pin>
	struct digitalDownS {
		static void apply() {
			GPIODATA( pin / 32 ) &= ~(1<<(pin%32));
		}
	};

static inline void digitalDown(const unsigned int pin)
{
	GPIODATA( pin / 32 ) &= ~(1<<(pin%32));
}

template<unsigned int pin>
	struct pinModeInputS {
		static void apply() {
			GPIOTRIS( pin / 32 ) |= (1<<(pin%32));
		}
	};

template<unsigned int pin>
	struct pinModeOutputS {
		static void apply() {
			GPIOTRIS( pin / 32 ) &= ~(1<<(pin%32));
		}
	};

template<unsigned int pin, bool val>
	struct digitalWriteS {
		static void apply() {
			if (val)
				digitalUpS<pin>::apply();
			else
				digitalDownS<pin>::apply();
		}
	};

static inline void digitalWrite(unsigned int pin, bool val)
{
	if (val)
		digitalUp(pin);
	else
		digitalDown(pin);
}

template<unsigned int pin, bool val>
	struct pinModeS {
		static void apply() {
			if (val)
				pinModeInputS<pin>::apply();
			else
				pinModeOutputS<pin>::apply();
		}
	};

static inline void pinModeInput(const unsigned int pin)
{
	GPIOTRIS( pin / 32 ) |= (1<<(pin%32));
}


static inline void pinModeOutput(const unsigned int pin)
{
	GPIOTRIS( pin / 32 ) &= ~(1<<(pin%32));
}

static inline void pinMode(unsigned int pin, bool val)
{
	if (val)
		pinModeInput(pin);
	else
		pinModeOutput(pin);
}

#endif
