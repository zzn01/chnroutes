#!/usr/bin/env sh
set -e

VPNService=$1
if [ ! -n "$VPNService" ] ; then
	echo "$0 <vpn name>"
	exit 1
fi

status=`scutil --nc status "${VPNService}"|head -n 1`

case $status in
	Connected) 
		scutil --nc stop "${VPNService}"
		sudo /etc/ppp/ip-down >/dev/null
		;;
	Disconnected)
		scutil --nc start "${VPNService}"
		sudo /etc/ppp/ip-up >/dev/null
		;;
	*)
		echo "unknow status:" $status
esac
