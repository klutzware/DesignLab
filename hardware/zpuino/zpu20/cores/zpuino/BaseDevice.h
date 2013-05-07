#ifndef __BASEDEVICE_H__
#define __BASEDEVICE_H__

#include "register.h"
#include "DeviceRegistry.h"

namespace ZPUino {

	class REGW {
	public:
		REGW(register_t reg): _r(reg) {};
		inline operator uint32_t const ()
		{
			return*_r;
		}
                void operator=(uint32_t value) { *_r=value; }
                inline void setBit(int bit) { *_r = *_r | BIT(bit); }
                inline void clearBit(int bit) { *_r = *_r & ~(BIT(bit)); }
	private:
		register_t _r;
	};

	class BaseDevice {
	public:
		BaseDevice(uint8_t instance=0xff): m_slot(0xff), m_instance(instance) {}
		inline REGW REG(uint32_t offset=0) {
			return REGW(m_baseaddress+offset);
		}
		int deviceBegin(uint8_t vendor, uint8_t product);
                int isError() { return m_slot==0xff; }
                inline uint8_t getSlot() const { return m_slot; }
	protected:
	private:
		uint8_t m_slot;
		uint8_t m_instance;
		register_t m_baseaddress;
	};
};

#endif
