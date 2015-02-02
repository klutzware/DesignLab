#ifndef __ARDUINO_H__
#define __ARDUINO_H__

#include <config.h>

#include <zpuino.h>
#include <delay.h>
#include <HardwareSerial.h>
#include <binary.h>
#include <Random.h>

#ifndef  boolean
#define boolean bool
#endif

#ifndef _BV
#define _BV(x) (1<<(x))
#endif

using namespace ZPUino;

#endif
