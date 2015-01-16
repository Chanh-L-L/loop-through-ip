#!bin/sh

ip="130.216.158"

# the last 3 digits of the ipaddress
suffix=0

for i in {0..510}
do
	if [ "$ip.$suffix" != "$ip.0" ] && [ "$ip.$suffix" != "$ip.255" ]
	then
		curl "$ip.$suffix:80" -m 1
		if [ "$?" = "0" ]
		then
			echo "$ip.$suffix:80 OK" >> output.txt
		else 
			echo "$ip.$suffix:80 FAIL" >> output.txt
		fi

		curl "$ip.$suffix:443" -m 1
		if [ "$?" = "0" ]
		then
			echo "$ip.$suffix:443 OK" >> output.txt
		else
			echo "$ip.$suffix:443 FAIL" >> output.txt
		fi
	fi

	((suffix++))
	
	# reset the suffix and move to 130.216.159
	if [ "$i" = "254" ]
	then
		suffix=0
		ip="130.216.159"
	fi 
done
