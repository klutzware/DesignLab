#include "HardwareSerial.h"
#include "zfdevice.h"

HardwareSerial Serial(1); /* 1st instance/slot */

void HardwareSerial::begin_slow(const unsigned int baudrate) {
	REG(1) = BAUDRATEGEN(baudrate)|BIT(UARTEN);
}

void HardwareSerial::flush() {
	while (REG(1) & 4);
}

size_t HardwareSerial::write(unsigned char c) {
	while ((REG(1) & 2)==2);
	REG(0) = c;
	return 1;
}

#ifdef HAVE_ZFDEVICE

/* ZPUino File Device support */

static ssize_t zf_serial_read(void *ptr, void *dest, size_t size)
{
    return -1;
}
static ssize_t zf_serial_write(void *ptr, const void *src, size_t size)
{
    HardwareSerial *f = static_cast<HardwareSerial*>(ptr);
    return f->write((const uint8_t*)src, size);
}


static struct zfdevops zf_serial_devops = {
    &zf_serial_read,
    &zf_serial_write
};

extern "C" void stdio_register_console(const char *device);

int serial_register_device(const char *name, void*data)
{
    char fname[32];
    int r = zfRegisterDevice(name,&zf_serial_devops, data);
    if (r==0) {
        sprintf(fname,"dev:%s", name);
        stdio_register_console(fname);
    }
    return r;
}

#endif