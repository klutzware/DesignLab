#ifdef HAVE_ZRT

#include "zrt_task.h"
#include "register.h"

#ifndef _BV
#define _BV(x) (1<<(x))
#endif

static unsigned zrt_stackend;
static unsigned zrt_stacksize;
static unsigned zrt_stackcurrent;

static struct zrt_tcb zrt_tasklist[ZRT_MAXTASKS];

struct zrt_tcb *zrt_currentTask = NULL;
volatile struct zrt_tcb *zrt_taskhead = NULL;

extern void ___switch_to(struct zrt_tcb *prev, struct zrt_tcb *next);
extern void ___switch_to_and_enable_interrupts(struct zrt_tcb *prev,struct zrt_tcb *next);

//extern void __debug(const char *c);
//extern void __debugint(int c);

#define __debug(x)
#define __debugint(x)

static inline void zrt_waitqueue_add(struct zrt_waitqueue**q, struct zrt_waitqueue *us)
{
    us->next = *q;
    *q = us;
}

static inline void zrt_waitqueue_wakeup(struct zrt_waitqueue**q)
{
    struct zrt_waitqueue *e = *q;
    *q = NULL;
    while (e) {
        e->func(e->param);
        e=e->next;
    }
}

void zrt_idlefunc()
{
    while (1) {
    }
}
static unsigned zrt_allocateStack(unsigned stacksize);

void zrt_init(unsigned stacktop, unsigned stacksize)
{
    struct zrt_tcb *idle = &zrt_tasklist[0];
    memset(zrt_tasklist,0,sizeof(zrt_tasklist));
    /*
     idle->next = NULL;
     idle->prev = NULL;
     idle->event = NULL;
     idle->sched_priority=0;
     idle->current_priority=0;
     */
    zrt_stacksize = stacksize;
    zrt_stackend = zrt_stackcurrent = stacktop;
    idle->pc = &zrt_idlefunc;
    idle->sp = zrt_allocateStack(8);
    idle->state = RUNNING;
    //zrt_currentTask = idle;
    zrt_taskhead = idle;
    zrt_currentTask = idle;


}

static void zrt_dumpTasks()
{
    struct zrt_tcb *tp = zrt_taskhead;
    __debug("Task list:\n");

    for (;tp;tp=tp->next) {
        __debug("Task ");
        __debugint((int)tp);
        __debug(" sched ");
        __debugint(tp->sched_priority);
        __debug(" curr ");
        __debugint(tp->current_priority);
        __debug("\n");
    }
    __debug("End list");

}

/* Update task, insert in task list in order.
 TODO: improve this.
 */
#if 0
static void zrt_updateTask(struct zrt_tcb*task)
{
    struct zrt_tcb *tp,*tprev;

    /* Unlink task */
    if (task->next!=NULL) {
        task->next->prev = task->prev;
    }
    if (task->prev!=NULL) {
        task->prev->next = task->next;
    }

    if (zrt_taskhead==task)
        zrt_taskhead = task->next;

    task->next=NULL;
    task->prev=NULL;


    __debug("This task: ");
    __debugint(task);
    __debug("\n");

    if (task->state == RUNNING) {
        tprev=NULL;
        tp=zrt_taskhead;
        __debug("Start\n");
        for (;; tprev=tp, tp=tp->next) {
            __debug("Iter task ");
            __debugint((int)tp);
            __debug("\n");

            if (tp==NULL)
                break;

            if (tp==task)
                continue;

            __debug("Info: ");
            __debugint(tp->current_priority);
            __debug(" ");
            __debugint(task->current_priority);
            __debug("\n");
            if (tp->current_priority >= task->current_priority) {
                continue;
            }
            __debug("Add\n");
            /* Add here */
            if (tprev!=NULL) {
                tprev->next = task;
            } else {
                zrt_taskhead = task;
            }
            task->next = tp;
            task->prev = tprev;
            tp->prev = task;
            __debug("TP next");
            __debugint((int)tp->next);
            __debug("\n");
            return;
        }
    } else {
        for (tp=zrt_taskhead; tp->next; tp=tp->next) {
        }
    }
    __debug("Add to end\n");
    if (tp->next == NULL) {
        /* Last task */
        tp->next = task;
        task->next = NULL;
        task->prev = tp;
    }
}
#endif

static unsigned zrt_allocateStack(unsigned stacksize)
{
    if (((zrt_stackend-zrt_stackcurrent)+stacksize)>=zrt_stacksize) {
        return 0;
    }
    unsigned s = zrt_stackcurrent;
    zrt_stackcurrent -= stacksize;
    return s;
}

static struct zrt_tcb *zrt_pickTask(struct zrt_tcb *current)
{
    struct zrt_tcb *sibling = current->next;

    if (NULL==sibling) {
        return zrt_taskhead;
    }

    /* Move current "down" the list */
    while (sibling) {
        if (sibling->sched_priority >= current->sched_priority)
            sibling = sibling->next;
        else
            break;
    }
    if (sibling->prev==current)
        return zrt_taskhead;

    /* Unlink task */
    if (current->prev) {
        current->prev->next = current->next;
    }
    current->next->prev = current->prev;

    /* Insert *before* sibling */
    if (zrt_taskhead==current) {
        zrt_taskhead = current->next;
    }
    current->next = sibling;
    current->prev = sibling->prev;
    sibling->prev = current;

    if (!current->prev) {
        zrt_taskhead = current;
    } else {
        current->prev->next = current;
    }
    return zrt_taskhead;
}


static void zrt_insertTask(struct zrt_tcb *current)
{
    struct zrt_tcb *task, *sibling = zrt_taskhead;
    for (task = zrt_taskhead->next; task; task=task->next) {
        if (task->sched_priority <= current->sched_priority) {
            sibling = task;
            break;
        }
    }
    /* Insert *before* sibling */
    current->next = sibling;
    current->prev = sibling->prev;
    sibling->prev = current;
    if (!current->prev) {
        zrt_taskhead = current;
    } else {
        current->prev->next = current;
    }
}

int zrt_createTask( void (*func)(void), unsigned priority, unsigned stacksize )
{
    struct zrt_tcb *task = &zrt_tasklist[0];
    int n;
    __disable_interrupts();
    __debug("Create new task");
    for (n=0;n<ZRT_MAXTASKS;n++) {
        if (task->sp==0) {
            /* Allocate stack */
            task->sp = zrt_allocateStack(stacksize);
            if (task->sp==0) {
                __enable_interrupts();
                asm("breakpoint");
                return E_ZRT_STACKSIZEEXCEEDED;
            }
            __debug("Alloc task @");
            __debugint(n);
            __debug("\n");

            task->pc = (unsigned)func;
            task->sched_priority = priority;
            task->current_priority = priority;
            task->next = NULL;
            task->prev = NULL;
            task->state = RUNNING;
            task->event = NULL;
            zrt_insertTask(task);
            __enable_interrupts();
            return n;
        }
        task++;
    }
    __enable_interrupts();
    return E_ZRT_TOOMANYTASKS;
}

void zrt_sched_finalize()
{
}
struct zrt_tcb *zrt_sched_tail()
{
    return zrt_pickTask(zrt_currentTask);
}

void zrt_main()
{
    struct zrt_tcb *task = zrt_taskhead;
    zrt_currentTask=task;

    TMR0CTL = 0;
    TMR0CNT = 0;
    TMR0CMP = (CLK_FREQ / 20000 )- 1;
    TMR0CTL = _BV(TCTLENA)|_BV(TCTLCCM)|_BV(TCTLDIR)| _BV(TCTLCP0)|_BV(TCTLIEN);
    INTRMASK = _BV(INTRLINE_TIMER0); // Enable Timer0 interrupt
    INTRCTL=1;  /* Enable interrupts */

    ___zrt_bootstrap(task);
}
void zrt_wakeup( struct zrt_tcb*task)
{
    task->state = RUNNING;
    zrt_insertTask(task);
}

void zrt_suspend(struct zrt_tcb*task)
{
    if (task->prev)
        task->prev->next = task->next;

    if (zrt_taskhead==task)
        zrt_taskhead = task->next;

    if (task->next)
        task->next->prev = task->prev;

    task->next = NULL;
    task->prev = NULL;
}

void zrt_schedule()
{
    __disable_interrupts();
    struct zrt_tcb *prev = zrt_currentTask;
    struct zrt_tcb *task = zrt_pickTask(prev);
    ___switch_to_and_enable_interrupts(prev, task);
}

int zrt_mutex_init(struct zrt_mutex *mutex)
{
    mutex->queue=NULL;
    mutex->val=1;
}

int zrt_mutex_lock(struct zrt_mutex *mutex)
{
    int pv;
    struct zrt_waitqueue q;
retry_lock:
    __disable_interrupts();
    mutex->val--;
    pv = mutex->val;
    __enable_interrupts();
    if (pv<0) {
        /* Mutex locked by others */
        q.next = NULL;
        q.func = &zrt_wakeup;
        q.param = zrt_currentTask;
        zrt_waitqueue_add( &mutex->queue, &q );
        zrt_suspend( zrt_currentTask );
        zrt_schedule();
        goto retry_lock;
    }
    return pv;
}

int zrt_mutex_unlock(struct zrt_mutex *mutex)
{
    int pv;
    int need_resched = 0;
    __disable_interrupts();
    //pv = mutex->val;
    mutex->val = 1;
    if (mutex->queue!=NULL)
        need_resched=1;
    __enable_interrupts();
    zrt_waitqueue_wakeup(&mutex->queue);
    if (need_resched)
        zrt_schedule();
    //return pv==0;
}

#endif
