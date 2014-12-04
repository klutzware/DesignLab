#!/bin/bash
sudo usermod -a -G dialout `whoami`
sudo chgrp dialout hardware/tools/papilio/papilio_loader/papilio-prog
sudo chgrp dialout hardware/tools/papilio/papilio-prog
sudo chgrp dialout hardware/tools/papilio/lin32/papilio-prog
sudo chgrp dialout tools/Papilio_Loader/programmer/linux32/papilio-prog
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", GROUP="dialout"' > /etc/udev/rules.d/papilio.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="7bc0", GROUP="dialout"' >> /etc/udev/rules.d/papilio.rules
echo 'ACTION=="add", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="7bc0", RUN+="/sbin/modprobe ftdi_sio" RUN+="/bin/sh -c '"'"'echo 0403 7bc0 > /sys/bus/usb-serial/drivers/ftdi_sio/new_id\'"'"'"' >> /etc/udev/rules.d/papilio.rules
sudo udevadm control --reload
