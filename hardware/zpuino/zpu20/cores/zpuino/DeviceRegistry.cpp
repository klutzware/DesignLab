#include "DeviceRegistry.h"
#include "register.h"

namespace ZPUino {

	int DeviceRegistry::registerDevice(uint8_t slot) {
		if (slot>=MAX_SLOTS)
			return -2;
		if (m_sDeviceRegistry & (1<<slot))
			return -1;
		m_sDeviceRegistry |= (1<<slot);
		return 0;
	}

	uint8_t DeviceRegistry::scanDevice(uint8_t vendor, uint8_t product, int instance) {
		uint8_t i;
		for (i=0;i<16;i++) {
			unsigned val = REGISTER(SYSCTLBASE,16+i);
			if (val!=0) {
				if (vendor!=VENDOR_ANY) {
					if (vendor != ((val>>8)&0xff))
                        continue; /* No match */
				}
                if (vendor!=PRODUCT_ANY) {
					if (product != (val&0xff))
						continue; /* No match */
				}
				if (isRegistered(i))
					continue;

				if (--instance==0)
					return i;
			}
		}
        return NO_DEVICE;
	}
	

	uint32_t DeviceRegistry::m_sDeviceRegistry = 0;
};
