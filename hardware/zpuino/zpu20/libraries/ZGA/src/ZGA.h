#include "Adafruit_GFX.h"

using namespace ZPUino;

class Font
{
public:
    Font() { data=NULL; }
    virtual ~Font() {}
    virtual unsigned getWidth() const = 0;
    virtual unsigned getHeight() const = 0;
    virtual int getBytesPerChar() const = 0;
    unsigned char *getChar(int c) {
        return data + (c*getBytesPerChar());
    }
    int getFontSize() const {
        return 256*getBytesPerChar();
    }
    unsigned char *data;
    unsigned char *getData() { return data; }
    int loadFromFile(const char *filename);
};

class ZGA_class: public BaseDevice, public Adafruit_GFX
{
    int buffered;
public:
    ZGA_class(): Adafruit_GFX(640,480) {
        buffered=0;
        cbuf=0;
    }
    void begin();

    uint16_t *getFramebuffer() {
        return (uint16_t*)&framebuffers[cbuf ^ buffered][0];
    }

    uint16_t *getDisplayFramebuffer() {
        return (uint16_t*)&framebuffers[cbuf][0];
    }

    unsigned getFramebufferSizeBytes() const {
        return sizeof(framebuffers)/2;
    }

    uint16_t *getPosition(int x, int y) {
        return &getFramebuffer()[x + y*640];
    }

    void setPixel(unsigned x, unsigned y, uint16_t value) {
        if (x>639)
            x=639;
        if (y>479)
            y=479;
        getFramebuffer()[x + y*640] = value;
    }

    void putChar(int x, int y, int c, Font &font);
    void putString(int x, int y, const char *c, Font &font);
    void syncVBlank();
    void clearArea(int sx, int sy, int w, int h, uint16_t color);
    void setBuffered()
    {
        buffered=1;
    }

    void swapBuffers();

    void swapBuffersAndCopy();

    virtual void drawPixel(int16_t x, int16_t y, uint16_t color) {
        setPixel(x,y,color);
    }

    uint16_t color565(unsigned r, unsigned g, unsigned b)
    {
        r   <<=2; r   &= (0x1f<<5);
        g   <<=7; g   &= (0x1f<<10);
        b    >>=3;
        b+=g;
        b+=r;
        return b;
    }

    int cbuf;
    uint32_t framebuffers[2][640*480/2];

};

extern ZGA_class ZGA;

