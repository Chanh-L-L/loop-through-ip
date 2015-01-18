#!bin/sh

ipaddress="130.216.158"

# the last 3 digits of the ipaddress
suffix=0

for i in {0..510}
do
	if [ "$ipaddress.$suffix" != "$ipaddress.0" ] && [ "$ipaddress.$suffix" != "$ipaddress.255" ]
	then
		curl -m 1 "$ipaddress.$suffix:80"
		if [ "$?" = "0" ]
		then
			echo "$ipaddress.$suffix:80 OK" >> output.txt
		else 
			echo "$ipaddress.$suffix:80 FAIL" >> output.txt
		fi

		curl -m 1 "$ipaddress.$suffix:443"
		if [ "$?" = "0" ]
		then
			echo "$ipaddress.$suffix:443 OK" >> output.txt
		else
			echo "$ipaddress.$suffix:443 FAIL" >> output.txt
		fi
	fi

	((suffix++))
	
	# reset the suffix and move to 130.216.159
	if [ "$i" = "254" ]
	then
		suffix=0
		ipaddress="130.216.159"
	fi 
done
