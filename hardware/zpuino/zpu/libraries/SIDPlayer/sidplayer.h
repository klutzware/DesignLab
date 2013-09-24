/*!
 *  @file		sidplayer.h
 *  Project		sidplayer Library
 *	@brief		sidplayer library for the ZPUino
 *	Version		1.0
 *  @author		Jack Gassett 
 *	@date		9/24/13
 *  License		GPL
 */

#ifndef LIB_SIDPLAYER_H_
#define LIB_SIDPLAYER_H_

#include <inttypes.h> 
#include <zpuino-types.h>
#include <zpuino.h>
#include "Arduino.h"
#include "SmallFS.h"
#include "cbuffer.h"
#include "SID.h"
#include <SD.h>
#include "retrocade_defs.h"

class SIDPLAYER
{
  public: 
    SIDPLAYER();
    void setup(SID* sid);
    void loadFile(const char* name);
    void play(boolean play);    
    boolean getPlaying();
    void audiofill();  
    void zpu_interrupt(); 
    void volume(int volume);   
  private:
    // struct ymframe {        
    	// unsigned char regval[14];
    // };      
    // CircularBuffer<ymframe,2> YMaudioBuffer; 
    unsigned int timerTicks;  
    int counter;
    byte volumeAdjust;
    int sidTimeStamp;
    int resetSIDFlag;
    SID* sid;
    SmallFSFile ymSmallFSfile;
    File sidSDfile;
    boolean playing; 
    kFileType fileType;  
   
};


#endif // LIB_SIDPLAYER_H_
