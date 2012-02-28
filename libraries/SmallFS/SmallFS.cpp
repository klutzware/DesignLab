#include "SmallFS.h"
#include <string.h>
#ifdef __linux__

#include <fcntl.h>
#include <unistd.h>
#include <endian.h>
#include <stdio.h>

#define BE32(x) be32toh(x)

#else

#include "WProgram.h"

#define BE32(x) x

#endif

#undef SMALLFSDEBUG

int SmallFS_class::begin()
{

#ifdef __linux__
	fsstart = 0;
	fd = ::open("smallfs.dat",O_RDONLY);
	if (fd<0) {
		perror("Cannot open smallfs.dat");
		return -1;
	}
#else
	struct boot_t *b = (struct boot_t*)bootloaderdata;
	fsstart = b->spiend;

#endif
	offset = 0xffffffff;

	read(fsstart, &hdr,sizeof(hdr));

#ifdef SMALLFSDEBUG

	unsigned debug;

	Serial.print("Read magic ");
	Serial.println(hdr.magic);
	Serial.print("SPI end ");
	Serial.println(fsstart);

	Serial.print("Bdata at ");
	Serial.println((unsigned)b);
	// Test read

	read(fsstart - 8, &debug,sizeof(debug));
	Serial.print("DD1 ");
	Serial.println(debug);
	read(&debug,sizeof(debug));
	Serial.print("DD2 ");
	Serial.println(debug);
	read(&debug,sizeof(debug));
	Serial.print("DD3 ");
	Serial.println(debug);

#endif

	if(BE32(hdr.magic) == SMALLFS_MAGIC)
		return 0;
	return -1;
}

void SmallFS_class::seek_if_needed(unsigned address)
{
	if (address!=offset)
	{
		spi_disable();
		spi_enable();
		spiwrite(0x0B);
#ifdef SMALLFSDEBUG
		Serial.print("Seeking to ");
		Serial.println(address);
#endif
		spiwrite(address>>16);
		spiwrite(address>>8);
		spiwrite(address);
		spiwrite(0);
		spiwrite(0); // Read ahead
        offset = address;
	}
}

unsigned SmallFS_class::readByte(unsigned address)
{
	seek_if_needed(address);
	unsigned v = spiread(); // Already cached
	spiwrite(0);
	offset++;
	return v;
}


void SmallFS_class::read(unsigned address, void *target, unsigned size)
{
#ifdef __linux__
	if (fd>=0) {
		::read(fd,target,size);
	}
#else
	seek_if_needed(address);

	unsigned char *p=(unsigned char*)target;
	while (size--) {
		unsigned v = spiread(); // Already cached
		spiwrite(0);
		*p++=v;
		offset++;
	}
#endif
}

SmallFSFile SmallFS_class::open(const char *name)
{
	/* Start at root offset */
	unsigned o = fsstart + sizeof(struct smallfs_header);
	unsigned char buf[256];
	struct smallfs_entry e;

	int c;

	for (c=BE32(hdr.numfiles); c; c--) {

		read(o, &e,sizeof(struct smallfs_entry));
		o+=sizeof(struct smallfs_entry);

		read(o, buf,e.namesize);
		o+=e.namesize;

		buf[e.namesize] = '\0';
		/* Compare */
		if (strcmp((const char*)buf,name)==0) {
			
			// Seek and readahead
			seek_if_needed(BE32(e.offset) + fsstart);

			return SmallFSFile(BE32(e.offset) + fsstart, BE32(e.size));
		}
	}
	// Reset offset.
	offset=(unsigned)-1;

	return SmallFSFile();
}

int SmallFSFile::read(void *buf, int s)
{
	if (!valid())
		return -1;

	if (seekpos==filesize)
		return 0; /* EOF */

	if (s + seekpos > filesize) {
		s = filesize-seekpos;
	}
	SmallFS.read(seekpos + flashoffset, buf,s);

	seekpos+=s;
	return s;
}

int SmallFSFile::readCallback(int s, void (*callback)(unsigned char, void*), void *data)
{
	unsigned char c;
	int save_s;

	if (!valid())
		return -1;

	if (seekpos==filesize)
		return 0; /* EOF */

	if (s + seekpos > filesize) {
		s = filesize-seekpos;
	}
#ifdef SMALLFSDEBUG
	Serial.print("Will read ");
	Serial.print(s);
	Serial.print(" bytes from file at offset ");
	Serial.print(flashoffset);
	Serial.print(" seekpos is ");

	Serial.println(seekpos);
#endif

	//SmallFS.spi_enable();

	//SmallFS.startread( seekpos + flashoffset );
	save_s = s;
	unsigned tpos = seekpos + flashoffset;
	seekpos += s;

	while (s--) {
		c=SmallFS.readByte(tpos++);
		callback(c,data);
	}

	return save_s;
}

void SmallFSFile::seek(int pos, int whence)
{
	int newpos;

	if (whence==SEEK_SET)
		newpos = pos;
	else if (whence==SEEK_CUR)
		newpos = seekpos + pos;
	else
		newpos = filesize + pos;

	if (newpos>filesize)
		newpos=filesize;

	if (newpos<0)
		newpos=0;

	seekpos=newpos;
	SmallFS.seek(seekpos + flashoffset);
}

SmallFS_class SmallFS;
