#!/bin/bash

ipaddress="130.216.158"
ports=(80 443)

func_curl() {
	ipaddr=$1
	port=$2
	
	# Time in seconds
	duration=1
	
	# use sed to take the first dns and then remove a dot at the end of that dns
	dns=$(dig -x $ipaddr +short | sed -n 1p | sed '$s/\.$//')

	curl -m $duration "$ipaddr:$port" &> /dev/null	
	
	if [ "$?" = "0" ]
	then
		echo "$ipaddr,$dns,$port,OK"
	else 
		echo "$ipaddr,$dns,$port,FAIL"
	fi
}

for i in {0..510}
do
	suffix=$((i%255))
	
	if [ "$ipaddress.$suffix" != "$ipaddress.0" ] && [ "$ipaddress.$suffix" != "$ipaddress.255" ]
	then
		for p in ${ports[@]}
		do
			func_curl "$ipaddress.$suffix" "$p"
		done
	fi
	
	# Move to 130.216.159
	if [ "$i" = "254" ]
	then
		ipaddress="130.216.159"
	fi 
done
