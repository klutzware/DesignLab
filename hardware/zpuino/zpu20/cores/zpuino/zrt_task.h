#ifndef __ZRT_TASK_H__
#define __ZRT_TASK_H__

#ifdef HAVE_ZRT

#include "zrt_config.h"

#ifdef __cplusplus
extern "C" {
#endif


#define E_ZRT_TOOMANYTASKS -1
#define E_ZRT_STACKSIZEEXCEEDED -2

extern void __enable_interrupts();
extern void __disable_interrupts();

struct zrt_waitqueue
{
    struct zrt_waitqueue *next;
    void (*func)(void*);
    void *param;
};

struct zrt_mutex {
    struct zrt_waitqueue *queue;
    volatile int val;
};

#define ZRT_MUTEX_INITIALIZER {0,1}

int zrt_mutex_init(struct zrt_mutex *);
int zrt_mutex_lock(struct zrt_mutex *);
int zrt_mutex_unlock(struct zrt_mutex *);


typedef enum {
    RUNNING,
    SLEEPING
} zrt_task_status;




/* The task control block */
struct zrt_tcb {
    volatile unsigned sp;
    volatile unsigned pc;
    volatile unsigned memreg;
    unsigned sched_priority;
    unsigned current_priority;
    int wakeup;
    unsigned flags;
    zrt_task_status state;
    struct zrt_event *event;
    struct zrt_tcb *next;
    struct zrt_tcb *prev;
};

extern volatile unsigned __zrt_currentTick;
extern struct zrt_tcb *zrt_currentTask;

void zrt_schedule();
int zrt_createTask( void (*func)(void), unsigned priority, unsigned stacksize );
int zrt_destroyTask();
void zrt_init(unsigned stacktop, unsigned stacksize);
void zrt_wakeup( struct zrt_tcb *task);
void zrt_suspend(struct zrt_tcb*task);


#ifdef __cplusplus
}
#endif

#endif

#endif
