# BASH Scripts

I write scripts to fix a particular problem or to accomplish a routine task and I felt that these scripts might be of use to others. It should be noted that these scripts were written in Bash for Linux Mint (18.3, 19.x, 20, and LMDE 4) but they should work for most Ubuntu and Debian based distributions. I've run these scripts with no problems on Debian 10, Lubuntu 18.04, antiX  19, and MX Linux 18 and 19.

### battery-check

1. Displays information about charging status and battery health for a laptop battery and displays a message regarding the health of the battery based on a percentage of the actual capacity in relation to the original rated capacity.

2. The original script was based on a script written by Elias W. (eliasw4u on Ezeetalk.com). I changed the variable names and some of the routines, and added the routine to check the charging status.

3. This scripts extracts battery data from the battery information in the `/sys/class/power_supply/`directory and requires no special utilities such as `upower`.

### check-battery

1. Displays information about charging status and battery health for a laptop battery and displays a message regarding the health of the battery based on a percentage of the actual capacity in relation to the original rated capacity.

2. This  script uses the `upower` utility to obtain data on the battery charging status and capacity and pertient data is extracted and displayed.

### check-updates

1. Updates the list of available packages then displays the number of packages that are available to be upgraded. If any updates are available, they are listed and a menu is presented with options to install updates, to install updates and clean up, to remove orphan packages, or to defer the updates and exit.
2. Root (sudo) privileges are necessary for `apt`.
3. I find it very useful when checking for updates when accessing a remote system via SSH. Of course, the script also needs to be on the remote system.

### clean-bin

1. Cleans up the ~/bin directory by removing all backup files ending with a tilde and copying files recently created or modified to a designated folder which is set in the `$SCRIPTDIR` variable.
2. The script uses the `rsync` command to synchronize the ~/bin directory with the designated script archive. The `function` sub-directory is included in the synchronization while the `Testing` sub-directory is excluded. The `rsync` command can be modified to suit your needs.
3. If the script is run from anywhere other than the `~/bin` directory, it uses `pushd` to go to `~/bin` for the cleanup and then uses `popd` to return to directory from where it was launched.

### dos2linux

1. Removes DOS carriage return characters (`\r`) from text files created by DOS and Windows text editors so they work better with some Linux programs. The original file is retained and appended with a .bak extension.
2. The script takes the file to be processed as an argument and checks to see if it exists. A usage message is displayed if the file doesn't exist or no argument is passed.

### ip-info

1. Displays a system's basic IP information in an easy to read format.
2. Information displayed:
   * Public IP address
   * Local (private) IP address with CIDR notation (i.e., 192.168.1.100/24) for both wired and wireless interfaces, if available and active.
   * SSID and signal level for wireless connection, if available and active. **Note:** Signal level may not display for all wireless cards. In my testing, Broadcom BCM4313 and BCM43228 will not display the signal level while the Broadcom BCM43224 will. However, accordng to the `iwconfig` man page, the value may depend on the driver and hardware specifics.
   * Default gateway for all active interfaces.
   * DNS servers if set, otherwise displays the default gateway address.

### locale-fix.sh

1. Fixes an error that sometimes occurs with update-initramfs during an update and the following warning appears:
   
   > Warning: No support for locale: us_US.UTF-8

> The problem is that /usr/share/initramfs-tools/hooks/root_locale is expecting to see individual locale directories in /usr/lib/locale, but locale-gen is configured to generate an archive file by default.

2. On Linux Mint systems (and probably other Ubuntu-based distributions) locale information is often stored in a single archive and can't be read by update-initramfs. The fix is to purge the existing locales and to store them in individual directories instead of in an archive then run `update-initramfs` with the -u and -t flags.

### pwfeedback.sh

1. A menu-driven script to enable/disable the display of asterisks on the command line when typing in a sudo password.

2. The script assumes that if password feedback is enabled, it is either in `/etc/sudoers` or with `/etc/sudoers.d/0pwfeedback`.

3. The script checks for the term pwfeedback in `/etc/sudoers` or the existence of `/etc/sudoers.d/0pwfeedback`.
   
   1. If you wish to enable password feedback and it has not been already enabled, the `0pwfeedback` file is created. The is the method Linux Mint uses to enable this feature.
   
   2. if  password feedback is enabled and you wish to disable the feature, the `0pwfeedback` file is removed, if it exists. Otherwise, you are instructed to edit the sudoers file using 'sudo visudo' .

### rename-host

1. A script to rename the system's hostname, changing it in `/etc/hostname` and in `/etc/hosts`, ensuring that the hostname in each of the files is the same.

2. The script prompts the user to enter a new hostname and checks it against a set of basic rules for a proper hostname.
   
   - Allows only alphanumeric characters and the hyphen. The new hostname is converted to lowercase for compatilbility with distributions that do not allow uppercase hostnames (i.e., Debian).
   
   - Does not allow the hostname to begin or end with a hyphen.
   
   - Does not allow the hostname to begin with a digit.
   
   - Does not allow non-alphanumeric characters other than the hyphen.
   
   - Limits hostname length to 15 characters for NETBIOS compatibility.
   
   - Does not allow the new hostname to be identical to the old hostname (after conversion to lowercase).

3. After the hostname is changed in both `/etc/hostname` and `/etc/hosts`, it checks to ensure both files have the same hostname. If they don't match, the previous hostname and hosts files are restored.

4. The script checks to see if the input host name is the same as the current hostname.A reboot is required for the changes take effect.

### ren-ext

1. Uses the `rename` command to rename certain file extensions in a directory to conform to a preferred naming convention. The extension to be renamed is passed as a command line argument.
2. Sometimes when files are downloaded they sometimes have file extensions that are in all caps or using an alternative extension. The script renames the extensions to lowercase and in a conventional format.
3. The script checks to see if an argument has been passed. If no argument has been passed, an error message is displayed along with the proper syntax. A case statement is used to check the passed argument against the supported extensions and rename the file as appropriate.
4. The following file extensions are supported and any combination of upper and lower case characters may be used in the passed argument:

| File extension | Renamed to |
| -------------- | ---------- |
| AVI            | avi        |
| BAK            | bak        |
| FLV            | flv        |
| GIF            | gif        |
| htm HTM HTML   | html       |
| jpeg JPG       | jpg        |
| MP3            | mp3        |
| MP4            | mp4        |
| mpeg MPG       | mpg        |
| PDF            | pdf        |
| PNG            | png        |
| TXT            | txt        |
| WMV            | wmv        |

### ren-space

1. Uses `rename` to replace spaces in filenames with underscores. When run, the script renames every filename containing spaces in the current directory.

### rm-tilde

1. Removes backup files with a trailing tilde (~) in the current directory to include hidden (dot) files.
2. I wrote this script as a safeguard to prevent accidentally deleting all the files in a directory while attempting to type `rm \*~`. Sometimes fingers slip.

### set-resume-var

1. Sets the RESUME environmental variable to the UUID of the swap partition.

2. Sometimes during an update, `update-initramfs` will product an error similar to the following:
   
   ```bash
   I: The initramfs will attempt to resume from /dev/sda2
   I: (UUID=09e25397-4a2c-4fb0-a605-a7013eecb59c)
   I: Set the RESUME variable to override this.
   ```

3. The script extracts the swap partition UUID from the output of `blkid` and writes it to `/etc/initramfs-tools/conf.d/resume`. Then it will display the `resume` file before updating initramfs.

4. If no swap partition is found, such as in the case where a swap file is used instead of  a swap partition, the script will exit without changing  the `RESUME` variable.

### system-info

1. Gathers system information and writes it to a file in the user's home directory. The file includes the following information:
   * System manufacturer (dmidecode)
   * System product name, version, and serial number (dmidecode)
   * Operating system (uname)
   * Linux distribution (lsb_release)
   * Filesystem creation date (df, tune2fs)
   * CPU model (lscpu)
   * Amount of physical memory (free -h)
   * Graphics adapter (lspci)
   * Network adapters (wired and wireless) with device names and MAC addresses (lspci, nmcli, /sys/class/net/)
   * Hard disk information - model, serial number, and capacity (hdparm)
   * Partition information (lsblk)
   * Battery information (upower)
2. The file name is the hostname with an extension of .info and is created in the user's home directory as the information is displayed to the screen.
3. Root (sudo) privileges are required since it uses `dmidecode` and `hdparm` to extract some of the system data.
4. The `dmidecode` command may return errors on some systems which will be written to the file despite having STDERR redirected to /dev/null. These error messages can be safely ignored and can be removed from the resulting file with any text editor.
5. On some systems, extraneous hard disk information may be written to the screen that is usually not written to the file. This extra information may be disregarded and if it is written to the file, can be edited out.

### upper2lower

1. Uses `rename` to change uppercase filenames in a directory to lowercase.
2. If no filename is passed as an argument, the script assume that all files in the directory are to be changed and asks for confirmation before proceeding. If the action is confirmed, it changes every instance of a capital letter in all filenames in the current directory to lowercase. Pressing any key but 'Y' will cancel the script.
3. If the script is run against a specific file, it checks to be sure the file exists.

### Feedback:

Feel free to contact me with comments and suggestions. I can be reached through my blog, Twitter, and email.

* [GitHub](https://github.com/RickRomig/bashscripts)
* [Rick's Tech Stuff](https://ricktech.wordpress.com)
* [Twitter (@ludditegeek)](https://twitter.com/ludditegeek)
* Email: [rick.romig@gmail.com](mailto:rick.romig@gmail.com) or [rb_romig@twc.com](mailto:rb_romig@twc.com)

Richard Romig

 🇺🇸 🇵🇭

3 February 2021

### DISCLAIMER

THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL I BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS AND SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
