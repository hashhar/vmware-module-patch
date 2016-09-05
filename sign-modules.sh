#!/bin/sh

printf '%s\n' "Do you have a X.509 key to sign the modules? y/[N])"
read choice
# If we got n, N or no input, we consider that as a no.
if [ "$choice" = "n" -o "$choice" = "N" -o "x$choice" = "x" ]; then
	printf '%s\n' "Enter the CN (Common Name) for the key that will be created:"
	read cn
	openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=$cn/" && \
		printf '%\n' "Keys created successfully." && \
		key="MOK.der" && \
		priv="MOK.priv"
else
	printf '%s\n' "Enter the path to the .DER file:"
	read key
	# We got an empty input, exit.
	if [ "x$key" = "x" ]; then
		printf '%s\n' "Please re-run the script and answer correctly."
		exit
	fi
	printf '%s\n' "Enter the path to the .PRIV file:"
	read priv
	# We got an empty input, exit.
	if [ "x$priv" = "x" ]; then
		printf '%s\n' "Please re-run the script and answer correctly."
		exit
	fi
fi

for f in $(dirname "$(modinfo -n vmmon)")/*.ko; do
	printf '%s\n' "Signing $f"
	sudo "/usr/src/linux-headers-$(uname -r)/scripts/sign-file" sha256 "$priv" "$key" "$f"
done

printf '%s\n' "Checking if MOKManager.efi exists or not. We are looking in /boot."
sudo find /boot -iname MokManager.efi
sudo apt install mokutil
printf '%s\n' "Remember the password you are about to enter, you will need it when you reboot to enroll the key. This is just a one-time process though."
if [ $? -eq 0 ]; then
	mokutil --import "$key"
else
	printf '%s\n' "We coudln't find MOKManager.efi!"
	printf '\n\n%s\n' "INSTRUCTIONS:"
	printf '%s\n' "Get MokManager.efi and place it in /boot/efi/EFI/ubuntu/ (or something similar) and rerun this script or simply run the following command and reboot your system."
	printf '%s\n' "mokutil --import MOK.der"
fi

printf '%s\n' "Remember the password you just entered, you will need it when you reboot to enroll the key. This is just a one-time process though."

