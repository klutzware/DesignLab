#ifndef __BOARD_H__
#define __BOARD_H__

#ifndef CLK_FREQ
#define CLK_FREQ 96000000UL
#endif

/* LX9 bitfile is 0x5327C in size */

#define SPIOFFSET 0x54000

#ifndef BOARD_MEMORYSIZE
#error Undefined board memory size
#endif

#define BOARD_SPI_DIVIDER BIT(SPICP0)

#define IOBASE 0x08000000
#define IO_SLOT_OFFSET_BIT 23

#define __SST_FLASH__

// Wing1 Column A
// #define FPGA_PIN_P18 0
// #define FPGA_PIN_P23 1
// #define FPGA_PIN_P26 2
// #define FPGA_PIN_P33 3
// #define FPGA_PIN_P35 4
// #define FPGA_PIN_P40 5
// #define FPGA_PIN_P53 6
// #define FPGA_PIN_P57 7
// #define FPGA_PIN_P60 8
// #define FPGA_PIN_P62 9
// #define FPGA_PIN_P65 10
// #define FPGA_PIN_P67 11
// #define FPGA_PIN_P70 12
// #define FPGA_PIN_P79 13
// #define FPGA_PIN_P84 14
// #define FPGA_PIN_P86 15

//Wing1 Column B
// #define FPGA_PIN_P85 16
// #define FPGA_PIN_P83 17
// #define FPGA_PIN_P78 18
// #define FPGA_PIN_P71 19
// #define FPGA_PIN_P68 20
// #define FPGA_PIN_P66 21
// #define FPGA_PIN_P63 22
// #define FPGA_PIN_P61 23
// #define FPGA_PIN_P58 24
// #define FPGA_PIN_P54 25
// #define FPGA_PIN_P41 26
// #define FPGA_PIN_P36 27
// #define FPGA_PIN_P34 28
// #define FPGA_PIN_P32 29
// #define FPGA_PIN_P25 30
// #define FPGA_PIN_P22 31

// Wing2 Column A
// #define FPGA_PIN_P91 32
// #define FPGA_PIN_P92 33
// #define FPGA_PIN_P94 34
// #define FPGA_PIN_P95 35
// #define FPGA_PIN_P98 36
// #define FPGA_PIN_P2  37
// #define FPGA_PIN_P3  38
// #define FPGA_PIN_P4  39
// #define FPGA_PIN_P5  40
// #define FPGA_PIN_P9  41
// #define FPGA_PIN_P10 42
// #define FPGA_PIN_P11 43
// #define FPGA_PIN_P12 44
// #define FPGA_PIN_P15 45
// #define FPGA_PIN_P16 46
// #define FPGA_PIN_P17 47

// Other pins
#define FPGA_PIN_P24 48
// #define FPGA_LED_PIN 49

#define FPGA_PIN_FLASHCS     FPGA_PIN_P24

#define SPI_FLASH_SEL_PIN FPGA_PIN_FLASHCS

/* WING configuration */

#define WING_AL0 0
#define WING_AL1 1
#define WING_AL2 2
#define WING_AL3 3
#define WING_AL4 4
#define WING_AL5 5
#define WING_AL6 6
#define WING_AL7 7
#define WING_AH0 8
#define WING_AH1 9
#define WING_AH2 10
#define WING_AH3 11
#define WING_AH4 12
#define WING_AH5 13
#define WING_AH6 14
#define WING_AH7 15

#define WING_BL0 21
#define WING_BL1 20
#define WING_BL2 19
#define WING_BL3 18
#define WING_BL4 17
#define WING_BL5 16
#define WING_BL6 15
#define WING_BL7 14
        
#define WING_CL0 22
#define WING_CL1 24
#define WING_CL2 26
#define WING_CL3 28
#define WING_CL4 30
#define WING_CL5 32
#define WING_CL6 34
#define WING_CL7 36
#define WING_CH0 38
#define WING_CH1 40
#define WING_CH2 42
#define WING_CH3 44
#define WING_CH4 46
#define WING_CH5 48
#define WING_CH6 50
#define WING_CH7 52

#define WING_DL0 53
#define WING_DL1 51
#define WING_DL2 49
#define WING_DL3 47
#define WING_DL4 45
#define WING_DL5 43
#define WING_DL6 41
#define WING_DL7 39
#define WING_DH0 37
#define WING_DH1 35
#define WING_DH2 33
#define WING_DH3 31
#define WING_DH4 29
#define WING_DH5 27
#define WING_DH6 25
#define WING_DH7 23

//Wing 1 Column A
#define WA0 0
#define WA1 1
#define WA2 2
#define WA3 3
#define WA4 4
#define WA5 5
#define WA6 6
#define WA7 7
#define WA8 8
#define WA9 9
#define WA10 10
#define WA11 11
#define WA12 12
#define WA13 13

//Wing 1 Column B
#define WB0 21
#define WB1 20
#define WB2 19
#define WB3 18
#define WB4 17
#define WB5 16
#define WB6 15
#define WB7 14

//Wing 2 Column C
#define WC0 22
#define WC1 24
#define WC2 26
#define WC3 28
#define WC4 30
#define WC5 32
#define WC6 34
#define WC7 36
#define WC8 38
#define WC9 40
#define WC10 42
#define WC11 44
#define WC12 46
#define WC13 48
#define WC14 50
#define WC15 52

//Wing 2 Column D
#define WD0 53
#define WD1 51
#define WD2 49
#define WD3 47
#define WD4 45
#define WD5 43
#define WD6 41
#define WD7 39
#define WD8 37
#define WD9 35
#define WD10 33
#define WD11 31
#define WD12 29
#define WD13 27
#define WD14 25
#define WD15 23

// ******** Define AH/AL syntax
//Wing 1 Column A
#define WAL0 0
#define WAL1 1
#define WAL2 2
#define WAL3 3
#define WAL4 4
#define WAL5 5
#define WAL6 6
#define WAL7 7
#define WAH0 8
#define WAH1 9
#define WAH2 10
#define WAH3 11
#define WAH4 12
#define WAH5 13

//Wing 1 Column B
#define WBL0 21
#define WBL1 20
#define WBL2 19
#define WBL3 18
#define WBL4 17
#define WBL5 16
#define WBL6 15
#define WBL7 14

//Wing 2 Column C
#define WCL0 22
#define WCL1 24
#define WCL2 26
#define WCL3 28
#define WCL4 30
#define WCL5 32
#define WCL6 34
#define WCL7 36
#define WCH0 38
#define WCH1 40
#define WCH2 42
#define WCH3 44
#define WCH4 46
#define WCH5 48
#define WCH6 50
#define WCH7 52

//Wing 2 Column D
#define WDL0 53
#define WDL1 51
#define WDL2 49
#define WDL3 47
#define WDL4 45
#define WDL5 43
#define WDL6 41
#define WDL7 39
#define WDH0 37
#define WDH1 35
#define WDH2 33
#define WDH3 31
#define WDH4 29
#define WDH5 27
#define WDH6 25
#define WDH7 23

#endif
