#ifndef __ZRTTIMER_H__
#define __ZRTTIMER_H__

#ifdef HAVE_ZRT

#ifdef __cplusplus
extern "C" {
#endif

struct zrt_timer {
    unsigned expires;
    void (*func)(void*);
    void *param;
    struct zrt_timer *next;
};

void zrt_sleep(unsigned ticks);


#ifdef __cplusplus
}
#endif

#endif
#endif
