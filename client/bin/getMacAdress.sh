#!/usr/bin/env bash

#set -x
if [ -d /sys/class/net/eth0 ] ; then
	echo $(cat /sys/class/net/eth0/address)
elif [ -d /sys/class/net/eno1 ] ; then
	echo $(cat /sys/class/net/eno1/address)
else 	
	echo "ff:ff:ff:ff:ff:ff"
fi
