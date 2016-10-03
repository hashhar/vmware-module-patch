#!/bin/sh

INSERT='export LD_LIBRARY_PATH=\"/usr/lib/vmware/lib/libglibmm-2.4.so.1/:\$LD_LIBRARY_PATH\"'

SEARCH_WORKSTATION='export PRODUCT_NAME=\"VMware Workstation\"'
SEARCH_PLAYER='export PRODUCT_NAME=\"VMware Player\"'

##### VMware Workstation ######################################################
printf '%s\n' "Patching VMware Workstation launcher"
grep -q "$INSERT" "$(which vmware)"
if [ $? -ne 0 ]; then
	sudo sed -i "/$SEARCH_WORKSTATION/i \
		$INSERT" "$(which vmware)"
else
	echo "Launcher file at $(which vmware) is already patched."
fi

##### VMware Tray #############################################################
printf '%s\n' "Patching VMware Tray launcher"
grep -q "$INSERT" "$(which vmware-tray)"
if [ $? -ne 0 ]; then
	sudo sed -i "/$SEARCH_WORKSTATION/i \
		$INSERT" "$(which vmware-tray)"
else
	echo "Launcher file at $(which vmware-tray) is already patched."
fi

##### VMware Vim Cmd ###########################################################
printf '%s\n' "Patching VMware VimCMD launcher"
grep -q "$INSERT" "$(which vmware-vim-cmd)"
if [ $? -ne 0 ]; then
	sudo sed -i "/$SEARCH_WORKSTATION/i \
		$INSERT" "$(which vmware-vim-cmd)"
else
	echo "Launcher file at $(which vmware-vim-cmd) is already patched."
fi

##### VMware WSSC Admin Tool ###################################################
printf '%s\n' "Patching VMware WSSC Admin Tool launcher"
grep -q "$INSERT" "$(which vmware-wssc-adminTool)"
if [ $? -ne 0 ]; then
	sudo sed -i "/$SEARCH_WORKSTATION/i \
		$INSERT" "$(which vmware-wssc-adminTool)"
else
	echo "Launcher file at $(which vmware-wssc-adminTool) is already patched."
fi

##### VMware Player #############################################################
printf '%s\n' "Patching VMware Player launcher"
grep -q "$INSERT" "$(which vmplayer)"
if [ $? -ne 0 ]; then
	sudo sed -i "/$SEARCH_PLAYER/i \
		$INSERT" "$(which vmplayer)"
else
	echo "Launcher file at $(which vmplayer) is already patched."
fi

##### VMware FuseUI #############################################################
printf '%s\n' "Patching VMware FUSEUI launcher"
grep -q "$INSERT" "$(which vmware-fuseUI)"
if [ $? -ne 0 ]; then
	sudo sed -i "/$SEARCH_PLAYER/i \
		$INSERT" "$(which vmware-fuseUI)"
else
	echo "Launcher file at $(which vmware-fuseUI) is already patched."
fi

##### VMware NetCfg #############################################################
printf '%s\n' "Patching VMware NetCfg launcher"
grep -q "$INSERT" "$(which vmware-netcfg)"
if [ $? -ne 0 ]; then
	sudo sed -i "/$SEARCH_PLAYER/i \
		$INSERT" "$(which vmware-netcfg)"
else
	echo "Launcher file at $(which vmware-netcfg) is already patched."
fi

