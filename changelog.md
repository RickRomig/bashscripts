# Changelog for bashscripts
### 27 August 20019
**chekupdates v1.1.4**
* Changed variable names to all capital letters.

**clean-bin v1.2**
* Changed variable names to all capital letters.
* Added BINDIR variable to repesent ~/bin directory.
* In the menu, removed the options to copy modified files created in the last 3 and 4 days because I rarely go that long without cleaning out backups and copying modified files and it makes for a nicer looking display.

**ren-ext**
* Changed variable names to all capital letters.

**sysinfo v2.0.6**
* Changed variable names to all capital letters.

**upper2lower**
* Changed variable names to all capital letters.

### 21 August 2019
**sysinfo v2.0.5**
* Changed method of assigning the `bname` variable to prevent word splitting and update it from the legacy syntax.
```
# Old code:
battery=$(/usr/bin/upower -i `/usr/bin/upower -e | grep 'BAT'` \
  | awk '/native-path/ {print $2}')
# New code:
battery=$(/usr/bin/upower -i "$(/usr/bin/upower -e | grep 'BAT')" \
  | awk '/native-path/ {print $2}')
```

### 20 August 2019
**chkupdates v1.1.2**
* Renamed functions to prevent confusion with apt commands.

**sysinfo v2.0.4**
* Changed redirection to use the `tee` command to display the text while redirecting it to the .info file, thus eliminating the need to use the `cat` command ti display the file after it was written.

### 13 August 2019
**dos2linux**
* Changed the variable assignment of myscript, the name of script, to separate the name from the path.
```
# Old code:
myscript=$0
# New code:
myscript=$(basename "$0")
```

### 7 August 2019
**sysinfo**
* Added a check to be sure hdparm was installed since it may not be installed by default in many Debian and Ubuntu-bases systems.
```
# Added code:
dpkg -l | grep -qw hdparm || sudo apt install -yyq hdparm
```

### 25 July 2019
**chkupdates v1.1.2**
* Changed the update function.
```
# Old code:
sudo apt dist-upgrade
# New code:
sudo apt full-upgrade
```
* Moved `sudo apt autoremove` from the clean function and incorporated into remove function.
* Added "Update and remove orphan packages" to the menu.
* Added alldone function to display update completion message.

### 19 July 2019
**yt-dl-install**
* Added code to optionally create a youtube-dl update script and place it `/etc/cron.weekly` to automatically check for updates using anacron.
* Added code to create a temporary directory for the creation of the update script, z-ytdlup.sh. The update script will be copied to `/etc/cron.weekly`. When `yt-dl-install` exits the trap command will call the cleanup function to remove temporary directory.
* Added comments to explain pertinent sections of the script.

**yt-dl-remove**
* Created a script to remove youtube-dl from the system without installing the newest version. It will remove the version from the distribution repositories, the version downloaded from <https://yt-dl.org>, or both. When removing the yt-dl.org version, will also remove configuration files, if they exist, and the log file created by z-ytdlup.sh (created by yt-dl-install).

### 18 July 2019
**yt-dl-update**
* Created a short script to update youtube-dl which can be set up in crontab to be run as a cron job or copied as root into `/etc/cron.weekly` (or cron.monthly) to be run with anacron.

### 17 July 2019
**yt-dl-install**
* Removed `sudo apt remove -yyq youtube-dl` from the code removing the repository version of youtube-dl because `apt purge` removes the package along with any configuration files that might exist.

### 16 July 2019
**yt-dl-install**
* Added `sudo apt purge -yyq youtube-dl` to the code to remove the repository version of youtube-dl because simply removing the package did not keep it from being found by the `dpkg -l` command.

### 15 July 2019
**yt-dl-install**
* Changed the method to using `dpkg -l` to see if youtube-dl has been installed from the repository rather than checking for the file in `/usr/bin`.
```
# Old code:
if [ -f /usr/bin/youtube-dl ]; then
# New code:
if dpkg -l | grep -qw youtube-dl
then
```
* Removed the option for the user to choose whether or not to update. If youtube-dl is installed, the script will automatically run the update command.
* Added error checking to the curl download of youtube-dl If the download is successful, the script will display the result and assign the appropriate permissions to the file. If the download fails, an error message with an exit code will be displayed.

### 23 June 2018
**chkupdates**
* Moved the assingment of the nupd variable (number of available updates) to after `sudo apt update`so that the number of available updates is properly assigned.

**sysinfo**
* Moved variables holding hard drive information to a loop in the main portion of the script to display the information for all storage devices mounted to the computer.

### 19 June 2018
**chkupdates**
* Added a menu to chose options that can be taken if there are updates available.
* Added functions to install updates and to run commands to remove orphan packages and clean the apt cache

**clean-bin**
* Modified messages in the case actions to match select options.

### 17 June 2018
**sysinfo**
  * Streamlined the process to obtain the amount of physical memory in the system.
```
# Old code:
physmem=$(grep MemTotal /proc/meminfo | awk '{print $2}' | xargs -I {} echo "scale=4; {}/1024^2" | bc)
# New code:
physmem=$(awk '/MemTotal/ {print $2}' /proc/meminfo | xargs -I {} echo "scale=4; {}/1024^2" | bc)
```

**chkupdates**
* Removed redirectation after assigning number of updates to nupd variable because it was redundant.
```
# Old code:
nupd=$(apt upgrade -s 2>/dev/null | grep -P '^\d+ upgraded' | cut -d" " -f1) < /dev/null 2>&1
# New code:
nupd=$(apt upgrade -s 2>/dev/null | grep -P '^\d+ upgraded' | cut -d" " -f1)
```

### 16 June 2018
 * Added color to echo statements, particularly error messages, so they stand out more. The change was made to chkupdates, dos2linux, locale-fix.sh, and ren-ext.

### 10 June 2018
**sysinfo**
* Changed method for obtaining CPU model name to awk bcause using grep and cut produced exta spaces in the output on some systems.
```
# Old code:
cpuinfo=$(/usr/bin/lscpu | grep 'Model name' | cut -c 22-)
# New code:
cpuinfo=$(/usr/bin/lscpu | awk '/Model name/ {print $3" "$4" "$5" " $6" "$7" "$8" "$9}')
```
* Changed method for obtaining the hard drive model, serial number, and capacity to use awk
instead of grep and cut.
```
# Old code:
hdmodel=$(sudo /sbin/hdparm -I /dev/sda | grep 'Model Number' | cut -c 22-)
hdserial=$(sudo /sbin/hdparm -I /dev/sda | grep 'Serial Number' | cut -c 22-)
hdsize=$(sudo /sbin/hdparm -I /dev/sda | grep 'GB' | cut -c 38-)
# New code:
hdmodel=$(sudo /sbin/hdparm -I /dev/sda | awk '/Model Number/ {print $3" "$4}')
hdserial=$(sudo /sbin/hdparm -I /dev/sda | awk '/Serial Number/ {print $3}')
hdsize=$(sudo /sbin/hdparm -I /dev/sda | awk '/GB/ {print $7" "$8" "$9" "$10}')
```
* Changed method to obtain laptop battery information to use `upower` instead of using ls to list the contents of `/sys/class/power_supply`.
```
# Old code:
if [ "$(ls -A /sys/class/power_supply/)" ]; then
  echo -e "\nPower and battery:"
  ls -1 /sys/class/power_supply
fi
# New code:
battery=$(/usr/bin/upower -i `/usr/bin/upower -e | grep 'BAT'` | awk '/native-path/ {print $2}')
  [ -n "$battery" ] && echo -e "\nBattery:\t$battery"
```

### 5 June 2019
**clean-bin**
* Modified if statement to include test for one file to be removed.
* Added version information.
* Incorporated a menu to select the timeframe to copy new or modifiied scripts. The available choices include today, the last 24 hours, and two,  three or four days.

**rmtilde**
* Modified if statement to include test for one file to be removed.
* Added version information.

### 21 May 2019
**clean-bin**
* Moved `nbu` variable declarion to main part of the script before the if statement for removing `*~` files.

**ipinfo**
* Renamed ipinfo.sh to ipinfo.
* Modified script to show local IP addresses for both wired and wireless interfaces, if installed.
  * Added variables for network interfaces:
```
ethint=$(nmcli dev | awk '/ethernet/ {print $1}')
wifint=$(nmcli dev | awk '/wifi/ {print $1}')
```
  * Changed variales to obtain local IP addresses:
```
# Old code
localip=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')
# New code
localip1=$(ip -o -f inet addr show | awk -v name="$ethint" '$0~name {print $4}')
localip2=$(ip -o -f inet addr show | awk -v name="$wifint" '$0~name {print $4}')
```
  * Changed code to display local IP information:
```
# Old code
echo "Local IP:"
echo -e "\t$localip"
# New code
echo "Local IP:"
if [ -n "$ethint" ] && [ -n "$localip1" ]; then
      echo -e "\tEthernet: $localip1"
elif [ -n "$ethint" ]; then
      echo -e "\tEthernet: Not connected"
fi
if [ -n "$wifint" ] && [ -n "$localip2" ]; then
      echo -e "\tWireless: $localip2"
elif [ -n "$wifint" ]; then
      echo -e "\tWireless: Not connected"
fi
```
* Modified code to display the default gateway for each active network interface. Eliminated the `gateway` variable and entered the code directly into the section that displays the IP information.
```
# Old code
gateway=$(ip route | awk '/default/ {print $3}')
...
echo "Default Gateway:"
echo -e "\t$gateway"
# New code
echo "Default Gateway:"
/sbin/ip route | awk '/default/ {print "\t"$5"\t"$3}'
```

### 20 May 2019
**clean-bin**
* Added an improved method to count the number of `*~` files to be removed.
```
New code:
nbu=$(find . -maxdepth 1 -type f -name \*~  | wc -l)
if [ "$nbu" -eq "0" ]; then
    echo "No files ending with '~' found."
else
    echo "Cleaning up $nbu '~' backup files from /home/$user/bin..."
    find ./ -maxdepth 1 -type f -iname \*~ -print -exec rm {} \;
fi
```

**rmtilde**
* Added an improved method to count the number of `*~` files to be removed.
```
New code:
nbu=$(find . -maxdepth 1 -type f -name \*~  | wc -l)
if [ "$nbu" -eq "0" ]; then
    echo "No files ending with '~' found."
else
    echo "Removing $nbu '~' backup files in the current directory..."
    find ./ -maxdepth 1 -type f -iname \*~ -print -exec rm {} \;
fi
```

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
# Old Code:
if [ $nupd -gt 0 ]; then
    apt list --upgradeable
fi
# New Code:
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
# Old code:
rename -v 's/\.BAK$/\.bak/' *.BAK
# New Code:
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
# Old Code:
[ "$?" != "0" ]
# New code:
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
# Old code:
ls *~ > /dev/null 2>&1
if [ "$?" = "0" ]
then
    rm -v *~
fi
# New Code:
find ./ -maxdepth 1 -type f -iname "*~" -print -exec rm {} \;
```
#### 6 February 2018

**getinfo/sysinfo**

Improved the appearance of the displayed output and changed some methods of gathering system data. Renamed to sysinfo as a more descriptive file name.

#### 5 February 2018

**dos2linux**

Fixed variable name inside the if statement that checks to see if target file exists.
```
#Old code:
if [ ! -f "$myfile" ]; then
    echo "Error: $myscript not found."
    usage
fi
# New code:
if [ ! -f "$myfile" ]; then
    echo "Error: $myfile not found."
    usage
fi
```
