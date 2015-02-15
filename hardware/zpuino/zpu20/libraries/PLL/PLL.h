#ifndef __PLL_H__
#define __PLL_H__

#include "Arduino.h"

using namespace ZPUino;

class PLL_class: public BaseDevice
{
public:
    PLL_class(uint8_t instance=1): BaseDevice(instance) {}
    int begin();
    int begin(register_t base);
    int set(unsigned mult, unsigned div);
protected:
    void pll_apply_register( int reg, unsigned val, unsigned mask);
};

#endif
