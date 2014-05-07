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

void ZGA_class::allocateBuffers()
{
    framebuffers[0] = (uint32_t*)malloc( getFramebufferSizeBytes() );
    framebuffers[1] = (uint32_t*)malloc( getFramebufferSizeBytes() );
}

void ZGA_class::begin() {
    unsigned characteristics;
    int width, height;
    if (deviceBegin(0x08, 0x1B)==0) {
        /* Allocate buffers */
        characteristics = REG(1);
        width  = characteristics>>16;
        height = characteristics&0xffff;
        Adafruit_GFX::begin(width,height);
        allocateBuffers();
        Serial.println("Device is HDMI");

        memset(framebuffers[0],0,getFramebufferSizeBytes());
        memset(framebuffers[1],0,getFramebufferSizeBytes());

        REG(0) = (unsigned)&framebuffers[0][0];
        
    }  else if (deviceBegin(0x08, 0x1A)==0) {
        characteristics = REG(1);
        width  = characteristics>>16;
        height = characteristics&0xffff;
        Adafruit_GFX::begin(width,height);
        allocateBuffers();
        Serial.println("Device is VGA");

        memset(framebuffers[0],0,getFramebufferSizeBytes());
        memset(framebuffers[1],0,getFramebufferSizeBytes());

        REG(0) = (unsigned)&framebuffers[0][0];
        
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
        if (x>width()/font.getWidth()) {
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
    dest+=sx+(sy*width());
    while (h--) {
        int z = w;
        while (z--) {
            *dest++=color;
        }
        /* Move dest forward, to next line */
        dest+=width()-w;
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
    memcpy( getFramebuffer(), getDisplayFramebuffer(), width()*height()*2 );
}

ZGA_class ZGA;
