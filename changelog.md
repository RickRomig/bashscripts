# Changelog for bashscripts
### 17 May 2019
**chkupdates**
* Double-quoted variable references to prevent globbing and word splitting.
* Added a line to check for sudo privileges before clearing the screen and running the rest of the script.
```
# New code:
sudo ls > /dev/null 2>&1
clear
echo "Checking for updates..."
```

**clean-bin**
* Romoved the code which calculated the number of \*~ files to be processed, undoing the previous change.
* Double-quoted variable references to prevent globbing and word splitting.

**dos2linux**
*  Double-quoted variable references to prevent globbing and word splitting.

**ren-ext**
* Replaced `*` at the end of each `rename` command with `./*` so that file names containing dashes wouldn't be seen as options.

**renspace**
* Replaced `*` at the end of the `rename` command with `./*` so that file names containing dashes wouldn't be seen as options.
```
# Old code:
# check for filenames containing spaces
ls | egrep '. ' > /dev/null 2>&1
if [ "$?" -ne "0" ]; then
	echo "No filenames containing spaces found."
else
	rename -v 's/ /_/g' *
fi
# New code:
# check for filenames containing spaces
if find . -maxdepth 1 -type f | grep " " >/dev/null
then
  rename -v 's/ /_/g' ./*
else
  echo "No filenames containing spaces found."
fi
```

**rmtilde**
* Romoved the code which calculated the number of \*~ files to be processed, undoing the previous change.
```
# Old code:
if (( numf > 0 )) || (( dotf > 0 )); then
  echo "Removing $((numf+dotf)) backup files in the current directory ending with '~'..."
  find ./ -maxdepth 1 -type f -iname "*~" -print -exec rm {} \;
else
  echo "No files ending with '~' found."
fi
# New code:
echo "Removing backup files in the current directory ending with '~'..."
find ./ -maxdepth 1 -type f -iname "*~" -print -exec rm {} \;
```

**sysinfo**
* Changed the method for obtaining CPU information (useless cat)
```
# Old code:
cpuinfo=$(cat /proc/cpuinfo | grep 'model name' | uniq | cut -c 14-)
# New code:
cpuinfo=$(grep 'model name' /proc/cpuinfo | uniq | cut -c 14-)
```
* Placed commands redirecting and appending the sysinfo file between brackets to reduce the number of writes to the file.
* Added blank lines to the variable declarations to make the script more readable.

**upper2lower**
* Double-quoted variable references to prevent globbing and word splitting.
*  Replaced `*` at the end of the `rename` command with `./*` so that file names containing dashes wouldn't be seen as options.

### 16 May 2019
**clean-bin**
* Added a variable to hold the number of files ending with '~' and a conditional statement to determine if execution of find was necessary.
```
# Old code:
echo "Cleaning up ~ backup files ..."
find ./ -maxdepth 1 -type f -iname "*~" -print -exec rm {} \;
# New code:
num=$(ls -1 *~ 2>/dev/null | wc -l)
if (( num > 0 )); then
  echo "Cleaning up $num '~' backup files from ~/bin ..."
  find ./ -maxdepth 1 -type f -iname "*~" -print -exec rm {} \;
fi
```

**rmtilde**
* Added variables to hold the number of files ending with '~' and a conditional statement to determine if execution of find was necessary.
```
# Old code:
find ./ -maxdepth 1 -type f -iname "*~" -print -exec rm {} \;
# New code:
numf=$(ls -1 *~ 2>/dev/null | wc -l)
dotf=$(ls -1 .*~ 2>/dev/null | wc -l)
if (( numf > 0 )) || (( dotf > 0 )); then
  echo "Removing $((numf+dotf)) backup files in the current directory ending with '~'..."
  find ./ -maxdepth 1 -type f -iname "*~" -print -exec rm {} \;
else
  echo "No files ending with '~' found."
fi
```

### 10 April 2019
**dos2linux**
* Redirected error messages to STDERR.

**ren-ext**
* Redirected error messages to STDERR. Moved `exit` statement out of usage function and applied where needed in the script.

**renspace**
* Redirected STDERR to /dev/null with STDOUT.

**rmtilde**
* Replaced `ls` and if statements with a `find` command since `rm -v *~` did not remove hidden files.
```
find ./ -maxdepth 1 -type f -iname "*~" -print -exec rm {} \;
```

**sysinfo**
* Changed indentation of if statements.

**upper2lower**
* Redirected error messages to STDERR. Moved `exit` statement out of usage function and applied where needed in the script.
* Replaced the warrning message if there are no arguments with `usage` since the function already contains the warning.

#### 1 April 2018
**chkupdates**
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
