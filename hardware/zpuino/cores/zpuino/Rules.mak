CROSS=zpu-elf-

CC=$(CROSS)gcc
CXX=$(CROSS)g++
AR=$(CROSS)ar
OBJCOPY=$(CROSS)objcopy
SIZE=$(CROSS)size

EXTRACFLAGS+=$(PREFS___board___build___extraCflags)

CFLAGS=$(EXTRACFLAGS) -DZPU -Wall -O2 -ffunction-sections -fdata-sections -nostartfiles -mmult -mdiv -mno-callpcrel -mno-pushspadd -mno-poppcrel -I$(COREPATH)
CXXFLAGS=$(CFLAGS) -fno-exceptions -fno-rtti
ARFLAGS=crs
LDFLAGS=-nostartfiles -Wl,-T -Wl,$(COREPATH)/zpuino.lds -Wl,--relax -Wl,--gc-sections
ASFLAGS=$(PREFS___board___build___extraSflags)

$(TARGET).elf: $(TARGETOBJ) $(LIBS)
	$(CC) -o $@ $(TARGETOBJ) $(LDFLAGS) -Wl,--whole-archive $(LIBS) -Wl,--no-whole-archive

all-target: $(TARGET).elf $(TARGET).bin $(TARGET).size

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex $< $@

$(TARGET).size: $(TARGET).hex
	$(SIZE) $< > $@
