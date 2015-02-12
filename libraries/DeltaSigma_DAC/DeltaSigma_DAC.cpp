/*

 DeltaSigma_DAC - Summarize your library here.

 Describe your library here.

 License: GNU General Public License V3

 (C) Copyright (Your Name Here)
 
 For more help on how to make an Arduino style library:
 http://arduino.cc/en/Hacking/LibraryTutorial

 */

#include "Arduino.h"
#include "DeltaSigma_DAC.h"

DeltaSigma_DAC::DeltaSigma_DAC()
{

}

void DeltaSigma_DAC::setup(unsigned int wishboneSlot)
{
	this->wishboneSlot = wishboneSlot;
}

unsigned long DeltaSigma_DAC::readButtons()
{
	return REGISTER(IO_SLOT(wishboneSlot),1);
}

void DeltaSigma_DAC::writeLEDs(unsigned long value)
{
	REGISTER(IO_SLOT(wishboneSlot),0) = value;
}
