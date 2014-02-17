/*
 Posix-like utility functions
 */
#include "zposix.h"
#include "zpuino-types.h"
#include <stdarg.h>
#include <ctype.h>
#include <sys/errno.h>
#include <time.h>

#include "Arduino.h"
#include "zfdevice.h"

struct __filedes {
    //int backend_type;
    struct zfops *ops;
    void *data;
    int mode;
};

static struct __filedes __fds[MAX_FILES];

#define BACKEND_PRINT 1

/* Raw file I/O */

extern "C" int open(const char *pathname, int flags,...)
{
    char rdevice[16];
    int newfd=-1;
    int i;

    for (i=0;i!=MAX_FILES;i++) {
        if (__fds[i].ops == NULL) {
            newfd=i;
            break;
        }
    }

    if (newfd==-1)
        return newfd;

    __fds[newfd].mode = flags;

    const char *delim = strchr(pathname,':');

    if (NULL==delim)
        return -1;

    delim++;

    if (!*delim)
        return -1;

    if ((delim-pathname) > 15)
        return -1; /* Too large */

    strncpy(rdevice, pathname, delim-pathname);
    rdevice[delim-pathname-1] = '\0';

    /* Look it up */

    struct zfops *ops = zfFindBackend(rdevice);

    if (ops==NULL)
        return -1;

    
    void *handle = ops->open(delim);

    if (NULL==handle)
        return -1;

    __fds[newfd].ops = ops;
    __fds[newfd].data = handle;

    return newfd;
}

extern "C" int close(int fd)
{
    int ret = 0;
    if (__fds[fd].ops) {
        if (__fds[fd].ops->close) {
            __fds[fd].ops->close(__fds[fd].data);
        }
        __fds[fd].ops = NULL;
    }
    return ret;
}

extern "C" ssize_t read(int fd, void *buf, size_t count)
{
    int ret = -1;
    if (__fds[fd].ops) {
        if (__fds[fd].ops->read) {
            ret = __fds[fd].ops->read(__fds[fd].data,buf,count);
        }
    }
    return ret;

}
extern "C" ssize_t write(int fd, const void *buf, size_t count)
{
    int ret = -1;
    if (__fds[fd].ops) {
        if (__fds[fd].ops->write) {
            ret = __fds[fd].ops->write(__fds[fd].data,buf,count);
        }
    }
    return ret;
}

extern "C" void abort()
{
    while(1);
}

extern "C" char *strerror(int err)
{
    return "Unknown";
}


extern "C" off_t lseek(int fd, off_t offset, int whence)
{
    errno = -EINVAL;
    return (off_t)-1;
}

struct tm dummytm;

struct tm *gmtime(const time_t *timep)
{
    return &dummytm;
}

extern "C" void __attribute__((constructor)) __posix_init()
{
    static int initialized=0;
    int i;

    if (initialized)
        return;
    for (i=0;i!=MAX_FILES;i++) {
        __fds[i].ops=NULL;
    }
    initialized=1;
}
