#!/bin/bash

if [ ! $# -gt 4 ]
  then
  	echo
    echo "Invalid / incorrect / missing arguments supplied."
    echo "Expected parameters:"
    echo
    echo "entrypoint.sh {dynamic_dns_server} {your_domain} {password} {dynamic_dns_protocol} {host} {sleep_interval_sec}"
    echo
    echo "Example:"
    echo "entrypoint.sh dynamicdns.park-your-domain.com mydomain.com 12345 namecheap www"
    echo
    echo "{sleep_interval_sec} default = 3600, -1 means execute once and exit"
    echo "All other params are required."
    exit 1
fi

sleeptime=${6:-3600}
ddclient_flags='-verbose -noquiet'

on_die()
{
	echo "Stopping..."
	exit 0
}

trap 'on_die' TERM SIGINT

sed -i 's/{dynamic_dns_server}/'$1'/' /etc/ddclient.conf &&
sed -i 's/{domain}/'$2'/' /etc/ddclient.conf &&
sed -i 's/{password}/'$3'/' /etc/ddclient.conf &&
sed -i 's/{protocol}/'$4'/' /etc/ddclient.conf &&
sed -i 's/{host}/'$5'/' /etc/ddclient.conf &&

if [ "$sleeptime" -eq -1 ] ; then
	ddclient -daemon=0 $ddclient_flags | grep -i -q 'success';
else
	while timeout 10 ddclient $ddclient_flags | grep -i -q 'success'; do
    	sleep $sleeptime
	done
fi

