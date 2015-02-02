# loop-through-ipaddress

A script to loop through a range of ip addresses

Output format (CSV):  <b>ipaddress,dns,port,ok/fail</b>

WARNING: Avoid using <b>--connect-timeout</b>, curl still hangs for some ip addresses even there is a timeout.
