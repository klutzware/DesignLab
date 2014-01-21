#ifndef __ZPOSIX_H__
#define __ZPOSIX_H__

#include <sys/types.h>
#include <stdarg.h>

#ifndef MAX_FILES
#define MAX_FILES 16
#endif

#define O_RDONLY 0
#define O_WRONLY 1
#define O_RDWR   2

#ifdef __cplusplus
extern "C" {
#endif


int open(const char *pathname, int flags,...);
int close(int fd);
ssize_t read(int fd, void *buf, size_t count);
ssize_t write(int fd, const void *buf, size_t count);
void abort();
off_t lseek(int fd, off_t offset, int whence);


#ifdef __cplusplus
}
#endif

#endif
