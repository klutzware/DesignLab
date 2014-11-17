#ifdef HAVE_ZRT

#include "zrt_timer.h"
#include "zrt_config.h"
#include "zrt_task.h"

static struct zrt_timer *zrt_timershead = NULL;
extern unsigned int zrt_now;

void zrt_timerInit() {
    zrt_timershead = NULL;
};

int zrt_timerAdd(struct zrt_timer *timer)
{
    struct zrt_timer *tp = zrt_timershead;
    if (NULL==zrt_timershead) {
        zrt_timershead = timer;
        timer->next = NULL;
    } else {
        while ( (tp->expires > timer->expires) && tp->next )
            tp = tp->next;
        timer->next = tp->next;
        tp->next = timer;
    }
    return 0;
}

void zrt_timerRun()
{
    struct zrt_timer *tp = zrt_timershead;
    do {
        if (tp==NULL)
            return;
        if (tp->expires<=zrt_now) {
            tp->func(tp->param);
            zrt_timershead = tp->next;
        }
        tp = tp->next;
    } while (tp);
}

void zrt_sleep(unsigned ticks)
{
    struct zrt_timer t;
    t.expires = zrt_now + ticks;
    t.func = &zrt_wakeup;
    t.param = zrt_currentTask;
    t.next = NULL;
    zrt_timerAdd(&t);
    zrt_suspend(zrt_currentTask);
    zrt_schedule();
}

#endif
