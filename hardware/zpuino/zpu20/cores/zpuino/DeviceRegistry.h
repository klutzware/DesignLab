#ifndef __DEVICEREGISTRY_H__
#define __DEVICEREGISTRY_H__

#include "register.h"
#include <zpuino-types.h>

#define VENDOR_ANY 0xff
#define PRODUCT_ANY 0xff
#define FIRST_INSTANCE -1
#define NO_DEVICE 0xff
#define MAX_SLOTS 16

namespace ZPUino {
	class BaseDevice;

	class DeviceRegistry {
		friend class BaseDevice;

	protected:
		/**
		 *
		 * @brief Register device on a specified Wishbone Slot
		 * @param slot The slot to register
		 * @return 0 on success, -1 on failure (already registered)
		 */
		static int registerDevice(uint8_t slot);
		/**
		 * @brief Scan for a specified device on the Wishbone slots
		 * @param vendor Vendor id for the device, or VENDOR_ANY for all vendors
		 * @param product Product id for the device, or PRODUCT_ANY for all devices
		 * @param instance Instance number of this device or FIRST_INSTANCE for 1st available instance. The first instance
		 * number is always 1, not 0.
		 * @return The slot for the device, or NO_DEVICE if not found.
		 */
		static uint8_t scanDevice(uint8_t vendor, uint8_t product, int instance);
		/**
		 * @brief Check if any device is registered for a specific slot
		 * @param slot The slot to check
		 * @return true if a device is already registered there, false otherwise
		 */
		static bool isRegistered(uint8_t slot) { return m_sDeviceRegistry&(1<<slot); }
		/**
		 * @brief Release a device. This should be called from within end() if you have sucessufully
		 * acquired the device.
		 * @param slot The slot where the device is
		 * @return true if successfuly unregistered, false otherwise
		 */
		static int releaseDevice(uint8_t slot);
	private:
		static uint32_t m_sDeviceRegistry;
	};
};

#endif
