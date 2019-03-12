#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Please enter hello_info, virt_dev or clean_both."
	exit 1
fi

if [ "$1" = 'hello_info' ]; then 
	sudo insmod hello_info.ko 
	cat /proc/hello_info
fi 

if [ "$1" = 'virt_dev' ]; then 
	sudo insmod char_dev_virt.ko 
	dev="virtual_character_device"
	major="$(grep "$dev" /proc/devices | cut -d ' ' -f 1)"
	sudo mknod "/dev/$dev" c "$major" 0 
	cat /dev/virtual_character_device 
fi 

if [ "$1" = 'clean_both' ]; then 
	sudo rmmod hello_info 
	sudo rm /dev/virtual_character_device
	sudo rmmod char_dev_virt
fi 
