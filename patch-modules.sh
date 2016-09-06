#!/bin/sh

orig="$(pwd)"
cd /usr/lib/vmware/modules/source
tar xf vmnet.tar && \
	cd vmnet-only && \
	make
cd ..
cp vmnet.o "/lib/modules/$(uname -r)/misc/vmnet.ko"

tar xf vmmon.tar && \
	cd vmmon-only && \
	patch linux/driver.c < "$orig/vmmon-driver.patch"
make
cd ..
cp vmmon.o "/lib/modules/$(uname -r)/misc/vmmon.ko"

depmod -a

