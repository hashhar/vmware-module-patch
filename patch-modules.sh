#!/bin/sh

cd /usr/lib/vmware/modules/source
tar xf vmnet.tar && \
	cd vmnet-only && \
	make
cd ..
cp vmnet.o "/lib/modules/$(uname -r)/misc/vmnet.ko"

cp vmmon.tar
tar xf vmmon.tar
cd vmmon-only && \
	patch driver.c < ../vmmon-driver.patch && \
	make
cd ..
cp vmmon.o "/lib/modules/$(uname -r)/misc/vmmon.ko"

depmod -a
/etc/init.d/vmware restart

