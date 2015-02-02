#!/bin/bash
 
ipaddress="130.216.158"
schemes=("http://" "https://")
 
func_curl() {
        ipaddr=$1
        scheme=$2
 
        # Time in seconds
        duration=15
 
        # use sed to take the first dns and then remove a dot at the end of that dns
        dns=$(dig -x $ipaddr +short | sed -n 1p | sed '$s/\.$//')
 
        curl -k -m $duration "$scheme$dns" &> /dev/null
 
        if [ "$?" = "0" ]
        then
                echo "$scheme$dns,$ipaddr,OK" >> output.csv
        else
                echo "$scheme$dns,$ipaddr,FAIL" >> output.csv
        fi
}

if [ -f ./output.csv ]
then
        mv ./output.csv ./output.bak
fi

for i in {0..510}
do
        suffix=$((i%255))
 
        if [ "$ipaddress.$suffix" != "$ipaddress.0" ] && [ "$ipaddress.$suffix" != "$ipaddress.255" ]
        then
                for p in ${schemes[@]}
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