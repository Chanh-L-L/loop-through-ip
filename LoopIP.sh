#!bin/sh

ipaddress="130.216.158"

func_curl() {
	curl -m 1 "$1:$2"
	
	if [ "$?" = "0" ]
	then
		echo "$1:$2 OK" >> output.txt
	else 
		echo "$1:$2 FAIL" >> output.txt
	fi
}

for i in {0..510}
do
	suffix=$((i%255))
	
	if [ "$ipaddress.$suffix" != "$ipaddress.0" ] && [ "$ipaddress.$suffix" != "$ipaddress.255" ]
	then
		func_curl "$ipaddress.$suffix" 80
		func_curl "$ipaddress.$suffix" 443
	fi
	
	# Move to 130.216.159
	if [ "$i" = "254" ]
	then
		ipaddress="130.216.159"
	fi 
done
