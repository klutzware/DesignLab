#!/bin/bash
sudo usermod -a -G dialout `whoami`
sudo chgrp dialout hardware/tools/papilio/papilio_loader/papilio-prog
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", GROUP="dialout"' > /etc/udev/rules.d/papilio.rules
echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="7bc0", GROUP="dialout"' > /etc/udev/rules.d/papilio.rules

