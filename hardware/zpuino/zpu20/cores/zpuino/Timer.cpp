#include <Timer.h>
#include <register.h>
#include <zpuino.h>

#define VENDOR_ZPUINO       0x08
#define PRODUCT_ZPUINO_TIMERS 0x13

namespace ZPUino {

    Timers_class::Timers_class(): m_pwmTimerPtr(0), m_intrTimerPtr(0)
    {
    }

    void Timers_class::begin()
    {
        if (deviceBegin(VENDOR_ZPUINO, PRODUCT_ZPUINO_TIMERS)==0) {
            m_timer0.begin( getBaseRegister(), getSlot() );
            m_timer1.begin( getBaseRegister() + 64, getSlot()+1);
        }
    }

    int TimerInstance_class::setPeriodMilliseconds(unsigned ms) {
        unsigned maxvalue = (1<<getSize())-1;
        unsigned cmp=0;

        if (hasPrescaler()) {
            int i;
            for (i=0;i<8;i++) {
                unsigned long count = CLK_FREQ/timerPrescalerDividers[i]; /* This is one second */
                cmp = count / ms;
                if (cmp<maxvalue)
                    break;
            }
        } else {
            unsigned long count = CLK_FREQ; /* This is one second */
            cmp = count/ms;
            if (cmp>maxvalue)
                cmp=0;
        }
        if (cmp==0)
            return -1;

        /* Apply */
        setComparator(cmp);
        setCounter(0);
        return 0;
    }




    /*
     void TimerClass::setPWMFrequency(long int hz)
     {
     const int dividers[8] = {
     1,2,4,8,16,64,256,1024
     };

     int i;

     for (i=0;i<8;i++) {
     long count = CLK_FREQ/dividers[i];
     count /= hz;
     if (count<65535) {
     TMR1CNT=0;
     TMR1CMP=count;
     TMR1OCR=count>>1;
     TMR1CTL &= ~(BIT(TCTLCP0)|BIT(TCTLCP1)|BIT(TCTLCP2));
     TMR1CTL |= (i<<TCTLCP0);
     return;
     }
     }
     }
     */
#if 0
    void TimerClass::setPWMDuty(uint8_t val)
    {
        long cmp = count;
        cmp *= val;
        cmp >>= 8;
        //	TMR1OCR=cmp;
    }

    void TimerClass::setPWMFrequency(long int hz)
    {
        count =  (CLK_FREQ / hz) -1 ;
        TMR1CNT=0;
        TMR1CMP=count;
        //  TMR1OCR=count>>1;
        TMR1CTL &= ~(BIT(TCTLCP0)|BIT(TCTLCP1)|BIT(TCTLCP2));
        //TMR1CTL |= (i<<TCTLCP0);
    }

    void TimerClass::setPWMOutputPin(int pin)
    {
        pinMode(pin,OUTPUT);
        pinModePPS(pin,HIGH);
        outputPinForFunction( pin, IOPIN_TIMER1_OC);
    }
#endif

    int Timers_class::singleShot( int msec, void (*function)(void*), void *arg )
    {
        /* get a free timer */
        TimerInstance_class *tmr = getFreeTimer();

        if (0==tmr)
            return -1;

        m_intrTimerPtr = tmr;

        if (attachInterrupt(tmr->getInterruptLine(), &timerInterruptHandlerSS, (void*)this))
            return -1;
        if (tmr->setPeriodMilliseconds(msec)<0) {
            detachInterrupt(tmr->getInterruptLine());
            return -1;
        }
        return 0;

    }

    int Timers_class::singleShot( int msec, void (*function)(void))
    {
        return singleShot(msec, (void(*)(void*))function, 0);
    }

    int Timers_class::periodic( int msec, bool (*function)(void*), void *arg )
    {
        TimerInstance_class *tmr = getFreeTimer();

        if (0==tmr)
            return -1;

        m_intrTimerPtr = tmr;

        if (attachInterrupt(tmr->getInterruptLine(), &timerInterruptHandler, (void*)this)<0)
            return -1;
        if (tmr->setPeriodMilliseconds(msec)<0) {
            detachInterrupt(tmr->getInterruptLine());
            return -1;
        }
        return 0;
    }

    int Timers_class::periodic( int msec, bool (*function)(void) )
    {
        return periodic(msec, (bool(*)(void*))function, 0);
    }

    void Timers_class::timerInterruptHandler(void *arg)
    {
        Timers_class *hclass = static_cast<Timers_class*>(arg);
        if (!hclass->handleInterrupt()) {
            hclass->m_intrTimerPtr->stop();
            detachInterrupt(hclass->m_intrTimerPtr->getInterruptLine());
            hclass->m_intrTimerPtr=0;
        }
    }

    void Timers_class::timerInterruptHandlerSS(void *arg)
    {
        Timers_class *hclass = static_cast<Timers_class*>(arg);
        hclass->handleInterrupt();
        hclass->m_intrTimerPtr->stop();
        detachInterrupt(hclass->m_intrTimerPtr->getInterruptLine());
        hclass->m_intrTimerPtr=0;
    }

};
