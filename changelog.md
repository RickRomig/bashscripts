# Changelog for bashscripts

### 09 August 2020

**battery-check 0.2.4**

- Combined check for `charge_full*` and `energy_full*` into one if statement.

- Moved `BAT_HEALTH` variable assignment to be included with the CAP_PERCENT variable assignment in the 'else' portion of the if statement.

**check-battery 0.1.7**

- Checks to see if `upower` is installed and exits with an error message if it is not.

### 08 August 2020

**battery-check 0.2.3**

- Changed the order of the battery capacity display, showing the actual capacity before the design capacity, more closely resembling the `upower` output.

### 07 August 2020

**check-battery 0.1.5**

- Renamed from `bat-health` to `check-battery`.

- Added checks for case when the battery's actual capacity or design capacity is zero (battery is completely ded and unusable).

- Modified the execution section to use a single `if-then`statemenmt.

### 30 July 2020

**bat-health 0.1.1**

- Rename `bat-status` to `bat-health`.

- Rewrote most of the script to use `upower` to obtain information on battery charge and capacity rather than obtaining data from individual files under `/sys/class/power_supply/BAT` and performing calculations on the data.

### 04 July 2020

**rename-host 2.1.1**

- Added default case to the case statement that checks the new hostname against the rules.

### 03 July 2020

**rename-host 2.1.0**

- Script now  reads user input for the new hostname rather than passing it as a command line argument.

- Checks the new hostname against a set of basic rules for a proper hostname.
  
  - Allows only alphanumeric characters and the hyphen.
  
  - Does not allow the hostname to begin or end with a hyphen.
  
  - Does not allow the hostname to begin with a digit.
  
  - Does not allow non-alphanumeric characters other than the hyphen.
  
  - Hostname length is limited to 15 characters for NETBIOS compatibility.
  
  - Does not allow the new hostname to be identical to the old hostname (after conversion to lowercase).

- Converts new hostame to lowercase for compatilbility with distributions that do not allow uppercase hostnames (i.e., Debian).

### 15 June 2020

**ren-ext 2.0.2**

- Changed the expressions to be changed by the rename commands to uppercase for consistency.  They're case insensitive since the `shopt -s nocasematch` was set.

**set-resume-var 1.1.1**

- Changed the case actions to one line in the `antix_mx` function.

- Removed the code requiring a reboot at the end of the script. The decision to restart the system is up to the user.

- Removed the `anykey` function since it was no longer needed.

**system-info 2.17**

- Removed the splits in long lines for better readability.

- Replaced the ETHMAC and WIFIMAC variables with command substitution to extract the needed string.

### 31 May 2020

**set-resume-var 1.1.0**

- Added a function and conditional statement to detect if the system is running antiX or MX Linux and take appropriate action  to extract the swap partition UUID. Both antiX and MX Linux append the swap partition's label with the name of the distribution, e.g., `LABEL=swapantiX` or `LABEL=swapMX`.

- Added a line to exit the script if no swap partition is found in the `blkid` output which may be the case if a swap file is used instead of a swap partition.

### 30 May 2020

**clean-bin 2.0.7**

- Added `(( NBU != 0 )) &&` to the `remove_tilde` function so the `find` command that removes the tilde files only runs if there are tilde files to be removed.
  
  ```bash
  (( NBU > 0 )) && find ~/bin -type f -iname \*~ -print -exec rm {} \;
  ```

**rm-tilde 1.2.0**

- Replaced the `if-elif-else` used to determine whether file is singular or plural with a simple test statement .
  
  ```bash
  echo -n "Removing $NBU '~' backup "
  (( NBU == 1 )) && echo "file." || echo "files."
  ```

- Added a simple test statement to determine if command to delete ~ files should be run.
  
  ```bash
  (( NBU != 0 )) && find ./ -maxdepth 1 -type f -iname \*~ -print -exec rm {} \;
  ```

- Eliminated the `remove_tilde` function and incorporated the functionality into the main code (see above).

- **Note:** If you don't wish to see a listing of delted files, remove the `-print` option from the `find` command.

### 28 May 2020

**clean-bin 2.0.6**

- Changed `find` commands in the `remove_tilde` function to work from the `~/bin` directory instead of the current directory.

- Changed the `rsync` command to explicitly synchronize from `~/bin` rather than the current directory.

- Removed `pushd` and `popd` commands since operations now work with absolute directories rather than relative directories.

### 11 May 2020

**ip-info 2.1.1**

- Change output display for wireless information so labels are right-justified.

- Replaced deprecated `iwconfig` command with the `iw` command.
  
  ```bash
  # Old Code:
  WIFI_SIG=$(/sbin/iwconfig "$WIFI_INT" | awk -F'=' '/Signal/ { print $3 }')
  # New Code:
  WIFI_SIG="$(/sbin/iw "$WIFI_INT" station dump | awk '/signal:/ { print $2 }') dBm"
  ```

### 04 May 2020

**rename-host 2.0.1**

- Added a line to usage function to remind user to enclose new hostname in double-quotes.

- Changed the order of commands in changing the hostname to make backup copies of the original `/etc/hostname` and `/etc/hosts` before changing the files.

- Added `/etc/hosts` to the second `sed` command which had been mistakely omitted.

### 03 May 2020

**rename-host 2.0.0**

- Simplified the renaming process by using `sed` to change the hostname in both `/etc/hostname` and `/etc/hosts`.

- Modified method to extract hostname from `/etc/hosts`since some distributions, noteabley Antix and MX Linux, place the host name on a line after `127.0.0.1` rather than `127.0.1.1`. If the line containing `127.0.1.1` is not found then the script looks for the second instance of `127.0.0.1`

- The new hostname should be passed to the script in double-quotoes to prevent unexpected results. In testing wth AntiX and MX-Linux, the `sed` command produced several repeated characters when substituting the old host name with the new hostname unless the argument was in quotes.

### 23 April 2020

**ip-info 2.1.0**

- In the `show_wireless function`, added a check of the wireless device to check for Broadcom devices that are know not work with iwconfig to get the signal level. If the system uses one of these wireless devices, the `WIFI_SIG` variable is set to "Not avaliable."

- Broadcom models BCM4313 and BCM43228 have been tested and will not show the `iwconfig` signal level information. The Broadcom BCM43224 wireless device will provide the siginal level.

- In the `show_wireless function`, placed variable assignments for `WIFI_IP`, `WIFI_DEV`, and `WIFI_SIG` in an if-statement so these variables will not be set if `WIFI_INT` is empty.

### 18 April 2020

**clean-bin 2.0.5**

- Expanded remove_tilde function to include all code directly related to removing backup files ending with `*~`.

**ip-info 2.0.0**

- Moved logical sections of the script into individual function which are called by a main function.

- Moved variables into the functions in which they are used.

- Added color to the displayed labels to help them stand out.

**check-updates 1.2.5**

- If only one update is installed or deferred, the appropriate statement is singular, otherwise the plural is used.

- Added a function to handle for the case when updates are deferred.

- Consolidated function calls and commands in case options to a single line.

#### 17 April 2020

**ip-info 1.1.2**

- Modified variable assigments for wired and wireless interfaces and IP addresses. Local IP addresses are extracted only when the interface exists. Likewise, the wireless signal level is obtained only if the wireless interface has an IP address.

- The public IP address is displayed only if present, otherwise a message is displayed saying that no Internet address was found.

- Streamlined how the IP addresses are displayed. How the the information is displayed in the terminal and its format are unchanged.

### 16 April 2020

**ip-info 1.1.0**

- Added SSID and signal level when displaying wireless IP information.
- Created a variable for signial level  and added a test so the 'Signal' line is only printed if is the variable is not empty.

### 8 April 2020

**check-updates 1.2.4**

- In the Upate option menu, replaced "Exit without updating" with "Defer updates" since this option, when selected, actually states it is doing.

**rename-host**

- Added tor repository. Script to change a system's hostname in both `/etc/hostname` and in `/etc/hosts`.

**set-resume-var**

- Added to repository. Script to set the `RESUME` evironmental variable after you've recieve a Set RESUME error during an upgrade.

## 24 March 2020

**ren-space 2.0.3**

* Replaced if-else with && and || operators
  
  ```
  # Old code
  if find . -maxdepth 1 -type f | grep " " >/dev/null; then
   rename -v 's/ /_/g' ./*
  else
   echo "No filenames containing spaces found."
  fi
  # New code
  find . -maxdepth 1 -type f | grep " " >/dev/null && rename -v 's/ /_/g' .
    /* || echo "No filenames containing spaces found."
  ```

### 28 February 2020

**check-updates 1.2.3**

* Renamed the script from chkupdates to check-updates

**ip-info 1.0.6**

* Renamed the script from ipinfo to ip-info.

* Removed the variable for the bridged network device since it wasn't needed.

**ren-space 1.0.2**

* Renamed the script from renspace to ren-space.

**system-info 2.1.6**

* Renamed the script from sysinfo to system-info.

**rm-tilde4.1.4**

* Renamed the script from rmtilde to rm-tilde.

### 24 February 2020

**upper2lower 2.0.5**

* Split the warning in the usage function into two lines so that it it will be easier to read.

* Changed the file not found error message so that only "ERROR" is in red.

### 6 February 2020

**chkupdates 1.2.2**

* Added count of packages updated or available but not updated when the script exits.

### 31 January 2020

**ren-ext 2.0.2**

* Incorporated `?` wildcard to combine case matches for htm|html, jpeg|jpg, and mpeg|mpg.
* In usage() added a statement that input file extensions are case insensitive and changed file extensions will be lowercase.

### 23 January 2020

**clean-bin 2.0.4**

* If there are no '~' backup files to be removed, this fact is no longer displayed.
  
  ```
  # Old code:
  NBU=$(find ./ -type f -name \*~  | wc -l)
  if (( NBU == 0 )); then
    echo $'\n'$"$NBU backup files ending with '~' found in $BINDIR."
  elif (( NBU == 1 )); then
    echo $'\n'$"Removing $NBU '~' backup file in $BINDIR."
    remove_tilde
  else
    echo $'\n'$"Removing $NBU '~' backup files in $BINDIR."
    remove_tilde
  fi
  # New code:
  NBU=$(find ./ -type f -name \*~  | wc -l)
  if (( NBU == 1 )); then
    echo $'\n'$"Removing $NBU '~' backup file in $BINDIR."
    remove_tilde
  elif (( NBU > 1 ))
    echo $'\n'$"Removing $NBU '~' backup files in $BINDIR."
    remove_tilde
  fi
  ```

### 22 January 2020

**chkupdates 1.2.1**

* Added echo statement to display the elapsed time of the script when no updates are available.

### 7 January 2020

**sysinfo 2.1.5**

* Fixed the INFOFILE variable which prevented writing to the file.
  
  ```
  # Old code:
  INFOFILE="$HOMEDIR/$MYHOST.info"
  # New code:
  INFOFILE="$HOMEDIR/$LHOST.info"
  ```

### 6 January 2020

**sysinfo 2.1.4**

* Changed OSNAME variable to extract the name of the operating system rather than the distribution. Added variable to extract the distribution release.
  
  ```
  # Old code:
  OSNAME=$(/usr/bin/lsb_release -d | cut -f2)
  # New code:
  OSNAME=$(/bin/uname -o)
  DISTRO=$(/usr/bin/lsb_release -d | cut -f2)
  ```

* Renamed MYHOST variable to LHOST.
  
  ```
  # Old code:
  MYHOST=$HOSTNAME
  # New code:
  LHOST=$(/bin/uname -n)
  ```

### 3 January 2020

**dos2linux 1.0.4**

* Updated error messages

* Refined the routine to check arguments to use `if-elif-else` structure instead of nested `if` statements.
  
  ```
  # Old code:
  if [ -z "$1" ]; then
  echo -e "\e[1;41mError: No argments passed.\e[0m" >&2
  usage
  else
  FILE=$1
  if [ ! -f "$FILE" ]; then
    echo -e "\e[1;41mError: $FILE not found.\e[0m" >&2
    usage
  fi
  fi
  # New code:
  if [ -z "$1" ]; then
  echo -e "\e[1;41mError:\e[0m No argments passed." >&2
  usage
  elif [ ! -f "$1" ]; then
  echo -e "\e[1;41mError:\e[0m $1 not found." >&2
  usage
  else
  FILE=$1
  fi
  ```

### 21 December 2019

**sysinfo 2.1.3**

* Modified the INSTALLED variable used to determine the date the file system was created by using piping the output from `tune2fs -l` to awk instead of piping it to grep then piping that result to awk.
  
  ```
  # Old code:
  INSTALLED=$(sudo /sbin/tune2fs -l "$ROOTDEV" | grep "Filesystem created" \
  | awk '{print $5,$4,$7}')
  # New code:
  INSTALLED=$(sudo /sbin/tune2fs -l "$ROOTDEV" \
  | awk '/Filesystem created/ {print $5,$4,$7}')
  ```

### 30 November 2019

**chkupdates 1.1.9**

* Local hostname displayed in script header
* Displays the elasped time the script ran.

### 06 November 2019

**sysinfo 2.1.2**

* Changed how the `ETHMAC` and `WIFIMAC` variales are assigned.
  
  ```
  # Old code:
  read -r ETHMAC < "/sys/class/net/$ETHINT/address"
  ...
  read -r WIFIMAC < "/sys/class/net/$WIFIINT/address"
  # New code:
  ETHMAC=$(cat "/sys/class/net/$ETHINT/address")
  ...
  WIFIMAC=$( cat "/sys/class/net/$WIFIINT/address")
  ```

### 20 October 2019

**clean-bin v2.0.3**

* Replaced `$HOMEDIR` variable with the `$HOME` environmental variable.

### 9 October 2019

* Removed the youtube-dl utilities after establishing a new repository for them.

### 8 October 2019

**upper2lower v2.0.4**

* Corrected a variable name that caused the script to fail the file exists check when running the script against a single file.
  
  ```
  # Old code:
  elif [ -e "$MYFILE" ]; then
  # New code:
  elif [ -e "$FILE" ]; then
  ```

* Removed the call to the usage function the default choice of the case statement when `Y` is not chosen to confirm renaming all files in the directory. The usage message has already been displayed so repeating it is redundant. Replaced it with a statement that the script was exiting. Also removed the `exit` command since the script will exit anyway once it leaves the case statement.
  
  ```
  # Old code:
  * )
  usage
  exit
  ;;
  # New code:
  *)
  echo "Exiting the script. No files renamed." ;;
  ```

### 4 October 2019

**sysinfo v2.1.1**

* Added code to display the filesystem install date by using `df` to extract the the device containting the root partition and then `tune2fs` to get the creation date.
  
  ```
  # New code:
  ROOTDEV=$(/bin/df -P / | tail -1 | cut -d" " -f1)
  INSTALLED=$(sudo /sbin/tune2fs -l "$ROOTDEV" | grep "Filesystem created" | awk '{print $5,$4,$7}')
  ```

* In the code to extract the CPU model name, added a pipe to `sed` to remove the parenthesis and their contents.
  
  ```
  # Old code:
  CPUINFO=$(/usr/bin/lscpu | grep 'Model name' | cut -f 2 -d ":" | awk '{$1=$1}1')
  # New code:
  CPUINFO=$(/usr/bin/lscpu | grep 'Model name' | cut -f 2 -d ":" | awk '{$1=$1}1') | sed "s/([^)]*)//g")
  ```

* Changed formatting of the displayed output, replacing tabs with spaces and arranging data in a more readable layout.

### 2 October 2019

**sysinfo v2.1.0**

* Revised method to extact the CPU model name. Solves the problems of preceding spaces and cutting off longer CPU model names.
  
  ```
  # Old code:
  CPUINFO=$(/usr/bin/lscpu | awk '/Model name/ {print $3" "$4" "$5" "$6" " $7" "$8}')
  # New code:
  CPUINFO=$(/usr/bin/lscpu | grep 'Model name' | cut -f 2 -d ":" | awk '{$1=$1}1')
  ```

* Revised method to extract total system memory, displaying memory in a more generic manner.
  
  ```
  # Old code:
  PHYSMEM=$(awk '/MemTotal/ {print $2}' /proc/meminfo | xargs -I {} echo "scale=4; {}/1024^2" | bc)
  # New code:
  PHYSMEM=$(free -h | awk '/^Mem:/ {print $2}')
  ```

* Reivised method of extracting hard drive capacity from hdparm command . Displays capacity in GB and eliminates the parenthesis around the number.
  
  ```
  # Old code:
  HDSIZE=$(sudo /sbin/hdparm -I "${DISK}" | awk '/GB/ {print $7" "$8" "$9" "$10}')
  # New code:
  HDSIZE=$(sudo /sbin/hdparm -I "${DISK}" | awk '/GB/ {print $9" "$10}' | sed 's/[)(]//g')
  ```

### 24 September 2019

**sysinfo v2.0.8**

* Reverted back to the previous method of extracting CPU moden name. Using `cut` gave inconsistent results. On some systems `cut -c 22-` would display two extra spaces.
  
  ```
  # Old code:
  CPUINFO=$(/usr/bin/lscpu | grep 'Model name' | cut -c 22-)
  # New code:
  CPUINFO=$(/usr/bin/lscpu | awk '/Model name/ {print $3" "$4" "$5" " $6" "$7" "$8" "$9}')
  ```

### 23 September 2019

**upper2lower v2.0.3**

* Changed color of the error mages from a red block background to red foreground characters.

**rmtilde v1.1.3**

* moved the find command that removes tilde files to a `remove_tilde` function.

### 22 September 2019

**sysinfo v2.0.7**

* Updated variable assignment for operating system:
  
  ```
  # Old code:
  echo -e "Operating System: $(/usr/bin/lsb_release -d | cut -c 14-)\n"
  # New code:
  OSNAME=$(/usr/bin/lsb_release -d | cut -f2)
  echo -e "Operating System: $OSNAME\n"
  ```

* Updated variable assignment for CPU model:
  
  ```
  # Old code:
  CPUINFO=$(/usr/bin/lscpu | awk '/Model name/ {print $3" "$4" "$5" " $6" "$7" "$8" "$9}')
  # New code:
  CPUINFO=$(/usr/bin/lscpu | grep 'Model name' | cut -c 22-)
  ```

* Updated variable assignment for graphics adapter:
  
  ```
  # Old code:
  echo "Graphics Adapter:"
  echo -e "\t$(/usr/bin/lspci | grep 'VGA' | cut -c 36-)"
  # New code:
  VIDEO=$(/usr/bin/lspci | grep 'VGA' | cut -d ' ' -f5-)
  echo "Graphics:"
  echo -e "\t$VIDEO"
  ```

* Updated variable assignments for network devices:
  
  ```
  # Old code:
  ETHERNETDEV=$(/usr/bin/lspci | grep 'Ethernet controller' | cut -c 30-)
  WIRELESSDEV=$(/usr/bin/lspci | grep 'Network controller' | cut -c 29-)
  # New code:
  ETHERNETDEV=$(/usr/bin/lspci | grep 'Ethernet controller' | cut -d ' ' -f4-)
  WIRELESSDEV=$(/usr/bin/lspci | grep 'Network controller' | cut -d ' ' -f4-)
  ```

* Updated variable assignment for hard drive model number:
  
  ```
  # Old code:
  HDMODEL=$(sudo /sbin/hdparm -I "${DISK}" | awk '/Model Number/ {print $3" "$4}')
  # New code:
  HDMODEL=$(sudo hdparm -I /dev/sda | grep 'Model Number' | cut -c 22-)
  ```

### 17 September 2019

**clean-bin v2.0.0**

* Removed the menu that selected the date range of files to backed up and replaced it with an `rsync` command to synchronize the contents of the ~/bin directory with the designated script archive directory.
  
  ```
  rsync -arv --delete --exclude 'Testing' . "$SCRIPTDIR/"
  ```

### 13 September 2019

**clean-bin v1.2.3**

* Placed the find command that removes '~' in a function.
* Added the capability to remove `~` backup files one directory below `~/bin`.
* Added code to copy files in `~/bin/functions`, a directory of commonly used functions and code snippets.

**ipinfo v 1.0.4**

* Modified the lines that display the local IP address to include the associated network device.
* In the conditional statements for displaying local IP addresses, added a line to display "No device found" if the network device isn't present.

### 12 September 2019

**dos2linux v 1.0.2**

* Nested conditional statements that check command line arguments.

### 7 September 2019

**clean-bin v1.2.1**

* Changed directory variables.
* Changed conditional statements from single brackets to double-parenthesis.

**ren-ext v 2.0.1**

* Added `exit 1` to the usage function and removed it from the conditional statements in which `usage` appears.

**upper2lower v2.0.2**

* Fixed variable names, correcting those that were missed in previous updates.

### 5 September 2019

**chkupdates v1.1.5**

* Changed line displayed when exiting if there are availabel updates.
  
  ```
  # Old code:
  echo -e "\n\e[1;33mUpdates were not installed.\e[0m"
  # New code:
  echo -e "\n\e[1;33mUpdates available but not installed.\e[0m"
  ```

### 2 September 2019

**dos2linux v1.01**

* Added variables for version and update information.
* Added echo statements to show what the script is doing.

**ipinfo v1.02**

* Added variables for version and update information.

**ren-ext v2.0.0**

* Added variables for version and update information.
* In the usage function, revised the echo statement displaying supported extensions to display properly.

**renspace v1.01.**

* Added variables for version and update information.

**rmtilde v1.1.3**

* Added variables for version and update information.

**upper2lower v 2.0.1**

* Added variables for version and update information.

### 27 August 2019

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

### 23 June 2019

**chkupdates**

* Moved the assingment of the nupd variable (number of available updates) to after `sudo apt update`so that the number of available updates is properly assigned.

**sysinfo**

* Moved variables holding hard drive information to a loop in the main portion of the script to display the information for all storage devices mounted to the computer.

### 19 June 2019

**chkupdates**

* Added a menu to chose options that can be taken if there are updates available.
* Added functions to install updates and to run commands to remove orphan packages and clean the apt cache

**clean-bin**

* Modified messages in the case actions to match select options.

### 17 June 2019

**sysinfo**

* Streamlined the process to obtain the amount of physical memory in the system.
  
  ```
  # Old code:
  physmem=$(grep MemTotal /proc/meminfo | awk '{print $2}' | xargs -I {} echo "scale=4; {}/1024^2" | bc)
  # New code:
  physmem=$(awk '/MemTotal/ {print $2}' /proc/meminfo | xargs -I {} echo "scale=4; {}/1024^2" | bc)
  ```

**chkupdates**

* Removed redirection after assigning number of updates to nupd variable because it was redundant.
  
  ```
  # Old code:
  nupd=$(apt upgrade -s 2>/dev/null | grep -P '^\d+ upgraded' | cut -d" " -f1) < /dev/null 2>&1
  # New code:
  nupd=$(apt upgrade -s 2>/dev/null | grep -P '^\d+ upgraded' | cut -d" " -f1)
  ```

### 16 June 2019

* Added color to echo statements, particularly error messages, so they stand out more. The change was made to chkupdates, dos2linux, locale-fix.sh, and ren-ext.

### 10 June 2019

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
  
  * Changed variables to obtain local IP addresses:
    
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

* Double-quoted variable references to prevent globbing and word splitting.

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
* Replaced `*` at the end of the `rename` command with `./*` so that file names containing dashes wouldn't be seen as options.

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

#### 1 April 2019

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

#### 31 March 2019

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

#### 18 February 2019

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

#### 10 February 2019

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

#### 6 February 2019

**getinfo/sysinfo**

Improved the appearance of the displayed output and changed some methods of gathering system data. Renamed to sysinfo as a more descriptive file name.

#### 5 February 2019

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
