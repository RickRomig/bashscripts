# Changelog for bashscripts

#### 18 February 2018
**sysinfo**

Added code to get and display MAC address for netork interfaces.
```
	echo "Network Adapters:" >> $infofile
	echo -e "\tEthernet: $ethint = $ethernet" >> $infofile
	read ethadd < /sys/class/net/$ethint/address
	echo -e "\tMAC addr: $ethadd" >> $infofile
	if [ -n "$wireless" ]; then
		echo -e "\tWireless: $wifint = $wireless" >> $infofile
		read wifiadd < /sys/class/net/$wifint/address
		echo -e "\tMAC addr: $wifiadd" >> $infofile
fi
```
#### 10 February 2010

**chkupdates**

Changed variable names to lower case and enclosed variables in quotes that are in test brackets.

**upper2lower**

Changed variable names to lower case.

#### 8 February 2019
**clean-bin**

Replaced the following code to remove *~ backup files
```
	ls *~ > /dev/null 2>&1
	if [ "$?" = "0" ]
	then
		rm -v *~
	fi
```
with the following
```
	find ./ -maxdepth 1 -type f -iname "*~" -print -exec rm {} \;
```
#### 6 February 2018

**getinfo/sysinfo**

Improved the appearance of the displayed output and changed some methods of gathering system data. Renamed to sysinfo as a more descriptive file name.

#### 5 February 2018

**dos2linux**

Fixed variable name inside the if statement that checks to see if target file exists.
```
	if [ ! -f "$myfile" ]; then
		echo "Error: $myscript not found."
		usage
	fi
```
Changed to read
```
	if [ ! -f "$myfile" ]; then
		echo "Error: $myfile not found."
		usage
	fi
```
