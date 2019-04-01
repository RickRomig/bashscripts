# Changelog for bashscripts
#### 1 April 2018
* Removed echo statements to display number of available updates and to announce listing of updates since `apt -upgade` already shows number of updates.
* Replaced the if statement to run `apt list --upgradeable` if updates are available.
```
OLD CODE:
if [ $nupd -gt 0 ]; then
	apt list --upgradeable
fi
NEW CODE:
[ $nupd -gt 0 ] && apt list --upgradeable
```

#### 31 March 2018
**chkupdates**
* replaced instances of `apt-get` with `apt`. Backward compatibility with Ubuntu 16.04 and Linux Mint 17.x is no longer necessary due to end of life.
* Added `2>/dev/null` to `apt upgrade` command to prevent error: **WARNING: apt does not have a stable CLI interface. Use with caution in scripts.**  Apparently, `apt` displays this error when its ouput is piped to another command.
```
nupd=$(apt upgrade -s 2>/dev/null | grep -P '^\d+ upgraded'|cut -d" " -f1) \
>/dev/null 2>&1
```

#### 10 March 2019
**ren-ext**
* Made the case patterns case-insensitive by setting the`shopt` Bash builtin and changing the case patterns to lowercase.
```
shopt -s nocasematch
case
	bak)
		echo "Renaming .$ext files to .bak"
		rename -v 's/\.BAK$/\.bak/i' *
		;;
	...
esac
shopt -u nocasematch
```
* Made the rename commands case-insensitive by adding the `i` option and replacing `*.EXT` with `*`.
```
FROM
rename -v 's/\.BAK$/\.bak/' *.BAK
TO
rename -v 's/\.BAK$/\.bak/i' *
```
* Since supported extensions are now case-insensitive, removed the ls command and the following if statement to check if files with the given extension exist. If no files are renamed, no files are listed.
```
# Check to see if any files with the extension exist
ls *.$ext > /dev/null 2>&1
if [ "$?" -ne "0" ]; then
	echo "Error: No .$ext files exist in the current directory."
	usage
fi
```
* Added support for AVI, FLV, MPG, mpeg, and WMV extensions.

#### 8 March 2019
**clean-bin**

Shortened conditional statements for pushd and popd, eliminating if constructs.
```
[ "$olddir" != ~/bin ] && pushd ~/bin > /dev/null
[ "$olddir" != ~/bin ] && popd < /dev/null
```
**upper2lower**
Made minor modifications to clean up indentation and improve readability. No changes to functional code.

#### 21 February 2019
**ren-ext, renspace, rmtilde**

Since the tests for the exit status of commands are comparing integter values, I changed the scripts from
```
[ "$?" != "0" ]
```
to
```
[ "$?" -ne "0" ]
```

#### 19 February 2019
**ipinfo.sh**

New script to nicely display basic IP information.

#### 18 February 2018
**sysinfo**

Added code to display MAC addresses for netork interfaces.
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

Replaced the following code to remove \*~ backup files
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
