#!/bin/sh

orig="$(pwd)"
cd /usr/lib/vmware/modules/source
sudo tar xf vmnet.tar && \
	cd vmnet-only && \
	sudo make
cd ..
sudo cp vmnet.o "/lib/modules/$(uname -r)/misc/vmnet.ko"

sudo tar xf vmmon.tar && \
	cd vmmon-only && \
	sudo patch linux/driver.c < "$orig/vmmon-driver.patch"
sudo make
cd ..
sudo cp vmmon.o "/lib/modules/$(uname -r)/misc/vmmon.ko"

sudo depmod -a

