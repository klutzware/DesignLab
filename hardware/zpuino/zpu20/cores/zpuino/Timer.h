#ifndef __TIMER_H__
#define __TIMER_H__

#include <zpuino-types.h>
#include <register.h>
#include <BaseDevice.h>

namespace ZPUino
{
    const int timerPrescalerDividers[8] = {
        1,2,4,8,16,64,256,1024
    };

    class TimerInstance_class: public REGAccess
    {
    public:
        void begin(register_t base, int intline) {
            REGAccess::begin(base);
            m_intline=intline;
            /* Set up sane defaults */
            setUpDirection(true);
            setClearOnCompare(true);
        }
        int getInterruptLine() const {
            return m_intline;
        }
        bool hasPrescaler() {
            return REG(128) & (1<<10);
        }
        bool hasTSC() {
            return REG(128) & (1<<8);
        }
        bool hasBuffers() {
            return REG(128) & (1<<9);
        }
        int getNumberOfComparators() {
            return (REG(128)>>16) & 0xff;
        }
        int getSize() {
            return REG(128) & 0xff;
        }
        void setCounter(unsigned value) {
            REG(ROFF_TMR0CNT)=value;
        }
        void setComparator(unsigned value) {
            REG(ROFF_TMR0CMP)=value;
        }
        void setUpDirection(bool value) {
            REG(ROFF_TMR0CTL).bit(TCTLDIR) = value;
        }
        void setClearOnCompare(bool value) {
            REG(ROFF_TMR0CTL).bit(TCTLCCM) = value;
        }
        int setPeriodMilliseconds(unsigned ms);

        void start() {
            REG(ROFF_TMR0CTL).setBit(TCTLENA);
        }
        void stop() {
            REG(ROFF_TMR0CTL).clearBit(TCTLENA);
        }

    private:
        //bool m_interruptAttached;
        int m_intline;
    };

    class Timers_class: public BaseDevice
    {
    public:
        Timers_class();
        void begin();
        void setPWMFrequency(long int hz);
        void setPWMOutputPin(int);
        void setPWMDuty(uint8_t val);

        int singleShot( int msec, void (*function)(void*), void *arg );
        int singleShot( int msec, void (*function)(void));
        int periodic( int msec, bool (*function)(void*), void *arg );
        int periodic( int msec, bool (*function)(void) );

        void cancel();
    private:
        int installTimerInterruptHandler(int line);
        static void timerInterruptHandler(void *arg);
        static void timerInterruptHandlerSS(void *arg);
        bool handleInterrupt();
    protected:
        void isAvailable(TimerInstance_class*cptr);
        TimerInstance_class *getFreeTimer();
    protected:
        TimerInstance_class m_timer0, m_timer1;
        TimerInstance_class *m_pwmTimerPtr, *m_intrTimerPtr;
        void *m_timerArg;
        bool (*m_timerFunc)(void*);
        unsigned m_timerlock;
    };
};
#endif
