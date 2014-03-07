#include "ZGA.h"

int Font::loadFromFile(const char *filename)
{
    FILE *f = fopen(filename,"rb");
    if (NULL==f)
        return -1;
    data=(unsigned char*)malloc(getFontSize());
    fread(data,getFontSize(),1,f);
    fclose(f);
    return 0;
}

void ZGA_class::begin() {
    if (deviceBegin(0x08, 0x1B)==0) {
        REG(0) = (unsigned)&framebuffers[0][0];
        Serial.println("Device is HDMI");
        memset(framebuffers,0,sizeof(framebuffers));
    }  else if (deviceBegin(0x08, 0x1A)==0) {
        REG(0) = (unsigned)&framebuffers[0][0];
        Serial.println("Device is VGA");
        memset(framebuffers,0,sizeof(framebuffers));
    } else {
        Serial.println("Device not found");
    }
}

void ZGA_class::putChar(int x, int y, int c, Font &font)
{
    c&=0xff;
    x*=font.getWidth();
    y*=font.getHeight();
    unsigned char *source = font.getChar(c);
    int i,z;
    for (i=0;i<font.getHeight();i++) {
        unsigned char v = *source++;
        for (z=0;z<font.getWidth();z++) {
            int set = !!(v &0x80);
            if (set) {
                setPixel(x+z,y+i,0xffff);
            }
            v<<=1;
        }
    }
}

void ZGA_class::putString(int x, int y, const char *c, Font &font)
{
    while (*c) {
        putChar(x,y,*c,font);
        c++;
        x++;
        if (x> 640/font.getWidth()) {
            y++,x=0;
        }
    }
}
void ZGA_class::syncVBlank()
{
    while (!(REG(0)&1));
    /* Now, wait for vblank */
    while (REG(0)&1);
}

void ZGA_class::clearArea(int sx, int sy, int w, int h, uint16_t color)
{
    uint16_t *dest = getFramebuffer();
    dest+=sx+(sy*640);
    while (h--) {
        int z = w;
        while (z--) {
            *dest++=color;
        }
        /* Move dest forward, to next line */
        dest+=640-w;
        sy++;
    }
}
void ZGA_class::swapBuffers() {
    cbuf++;
    cbuf&=1;
    REG(0) = (unsigned)&framebuffers[cbuf][0];
}

void ZGA_class::swapBuffersAndCopy() {
    swapBuffers();
    syncVBlank();
    /* Copy old buffer into new buffer */
    memcpy( getFramebuffer(), getDisplayFramebuffer(), 640*480*2 );
}

ZGA_class ZGA;
