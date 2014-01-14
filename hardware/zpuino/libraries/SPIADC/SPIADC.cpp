#include "SPIADC.h"

void SPIADC::begin(CS SEL, WISHBONESLOT wishboneSlot, ADCBITS bits)
{

 SELPIN   = SEL;
 adcBits = bits;

 //SPI.begin(MOSI(WA14),MISO(WA13),SCK(WA15));
 SPI.begin(wishboneSlot);

 pinMode            (SELPIN , OUTPUT);
 digitalWrite       (SELPIN , HIGH);


//SPI.setBitOrder     (MSBFIRST);
SPI.setDataMode     (SPI_MODE3);
SPI.setClockDivider (SPI_CLOCK_DIV1024);


}

uint16_t SPIADC::read (byte pin)
{
uint16_t data ;
digitalWrite (SELPIN , LOW);

// 0000 0XXX
// 00XX X000

pin = pin << 3 ;
SPI.transfer(pin);
//reach 16 rising edge
SPI.transfer(0);
//last 8 bits
data  = SPI.transfer(0);
data  = data << 8;
data |= SPI.transfer(0);

digitalWrite(SELPIN,HIGH);

if ( adcBits ) return data  ; // 12 bit
else       return (data >> 4) ; //  8 bit

}


SPIADC analog ;
