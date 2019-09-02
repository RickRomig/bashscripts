# BASH Scripts

I write scripts to fix a particular problem or to accomplish a routine task and I felt that these scripts might be of use to others. It should be noted that these scripts were written in Bash for Linux Mint (18.3, 19.x, and LMDE 3) but they should work for most Ubuntu and Debian based distributions. I've run these scripts with no problems on Debian 10 and MX Linux 18.

### chkupdates
1. Updates the list of available packages then displays the number of updated packages that are available. If any updates are available, they are listed and a menu is presented with options to install updates, install updates and clean up, remove orphan packages, or exit without updating anything.
2. Root (sudo) privileges are necessary for `apt`.
3. I find it very useful when checking for updates when accessing a remote system via SSH. Of course, the script also needs to be on the remote system.

### clean-bin
1. Cleans up the ~/bin directory by removing all backup files ending with a tilde and copying files recently created or modified to a designated folder which is set in the `$SCRIPTDIR` variable.
2. The script incorporates a menu to select the timeframe for the new and modified scripts to be copied to an archival directory. Files from the current day, the previous 24 hours, or the last two days.
3. If the script is run from anywhere other than the `~/bin` directory, it uses `pushd` to go to `~/bin` for the cleanup and then uses `popd` to return to directory from where it was launched.

### dos2linux
1. Removes DOS carriage return characters ('\r') from text files created by DOS and Windows text editors so they work better with some Linux programs. The original file is retained and appended with a .bak extension.
2. The script takes the file to be processed as an argument and checks to see if it exists. A usage message is displayed if the file doesn't exist or no argument is passed.

### ipinfo
1. Displays a system's basic IP information in an easy to read format.
2. Information displayed:
 * Public IP address
 * Local (private) IP address with CIDR notation (i.e., 192.168.1.100/24) for both wired and wireless interfaces, if available and active.
 * Default gateway for all active interfaces.
 * DNS servers if system has a static IP, otherwise displays the DHCP server (default gateway) address.

### locale-fix.sh
1. Fixes an error that sometimes occurs with update-initramfs during an update and the following warning appears:
>Warning: No support for locale: us_US.UTF-8

>The problem is that /usr/share/initramfs-tools/hooks/root_locale is expecting to see individual locale directories in /usr/lib/locale, but locale-gen is configured to generate an archive file by default.

2. On Linux Mint systems (and probably other Ubuntu-based distributions) locale information is often stored in a single archive and can't be read by update-initramfs. The fix is to purge the existing locales and to store them in individual directories instead of in an archive then run `update-initramfs` with the -u and -t flags.

### ren-ext
1. Uses the `rename` command to rename certain file extensions in a directory to conform to a systematic naming convention. The extension to be renamed is passed as a command line argument.
2. Sometimes when files are downloaded they sometimes have file extensions that are in all caps or using an alternative extension. The script renames the extensions to lowercase and in a conventional form.
3. The script checks to see if an argument has been passed. If no argument has been passed, an error message is displayed along with the proper syntax. A case statement is used to check the passed argument against the supported extensions and rename the file as appropriate.
4. The following file extensions are supported and any combination of upper and lower case characters may be used in the passed argument:

| File extension | Renamed to |
|-----------|--------|
| AVI | avi
| BAK | bak
| FLV | flv
| GIF | gif
| htm HTM HTML | html
| jpeg JPG | jpg
| MP3 | mp3
| MP4 | mp4
| mpeg MPG | mpg
| PDF | pdf
| PNG | png
| TXT | txt
| WMV | wmv

### renspace
1. Uses `rename` to replace spaces in filenames with underscores. When run, the script renames every filename containing spaces in the current directory.

### rmtilde
1. Removes backup files with a trailing tilde (~) in the current directory to include hidden (dot) files.
2. I wrote this script as a safeguard to prevent accidentally deleting all the files in a directory while attempting to type `rm \*~`. Sometimes fingers slip.

### sysinfo
1. Gathers system information and writes it to a file in the user's home directory. The file includes the following information:
  * System manufacturer (dmidecode)
  * System product name, version, and serial number (dmidecode)
  * Operating System (lsb_release)
  * Amount of physical memory (/proc/meminfo)
  * CPU model (lscpu)
  * Graphics adapter (lspci)
  * Network adapters (wired and wireless) with device names and MAC addresses (lspci, nmcli, /sys/class/net/)
  * Hard disk information - model, serial number, and capacity (hdparm)
  * Partition information (lsblk)
  * Battery information (upower)
2. The file name is the hostname with an extension of .info and is created in the user's home directory. After the information is written to the file, it is displayed using the cat command.
3. Root (sudo) privileges are required since it uses `dmidecode` and `hdparm` to extract some of the system data.
4. The `dmidecode` command may return errors on some systems which will be written to the file despite having STDERR redirected to /dev/null. I've only seen this on my Lenovo M91p desktop PC when running Linux Mint 18.x (Ubuntu 16.04). These error messages can be safely ignored and can be removed from the resulting file with any text editor.

### upper2lower
1. Uses `rename` to change uppercase filenames in a directory to lowercase.
2. This script, when run without a filename as an argument, asks for confirmation before proceeding. If the action is confirmed, it changes every instance of a capital letter in all filenames in the current directory to lowercase. Pressing any key but 'Y' will cancel the script and usage instructions will be displayed.
3. If the script is run against a specific file, it checks to be sure the file exists.

### yt-dl-install
1. Installs the newest available version of youtube-dl from the [youtube-dl project](https://ytdl-org.github.io/youtube-dl/index.html), using the instructions given on the youtube-dl download page.
2. Although youtube-dl is included in the Debian and Ubuntu repositories, it is often well out of date and infrequently updated. The apt package manager usually installs youtube-dl in `/usr/bin/` while the project's download instructions suggest installing it in `/usr/local/bin/`.
3. If the script finds that youtube-dl has been installed by the package manager, it removes the package using `apt purge`. Then it checks to see if youtube-dl is installed (presumably from the youtube-dl project). If installed, the script displays the version number and attempts to update it. Otherwise, the newest version of youtube-dl is installed from yt-dl.org.
4. Once youtube-dl is installed, you can update it from a terminal with the command `sudo youtube-dl -U` since the yt-dl.org version should be the only version installed. Alternatively, the script can be used to update it.
5. During the yt-dl.org instillation of youtube-dl, the script copies a small script (if it exists in your ~/bin directory) to automatically update youtube-dl on a daily basis using anacron. The z-ytdlupdate script is set up to write the date and the output of the `youtube-dl -U` command to a log file in `/var/log`. The size is limited to the last 25 update attempts.
6. Entering `yt-dl-install -i` or `yt-dl-install --info` in the terminal displays information about the script.

### yt-dl-remove
1. Completely removes youtube-dl from the system whether it is the distribution repository version or the version downloaded from <https://yt-dl.org>. If both are installed, both will be removed.
2. If the `~/.config/youtube-dl/conf` or `/etc/youtube-dl.conf` configuration files exist, they will be removed. Be sure to make backup copies if you think you might need them.
3. If `z-ytdlupdate` exists in `/etc/cron.daily`, `/etc/cron.weekly`, or `/etc/cron.monthly` directories, it will be removed.
3. If the log file created by the automatic updates (`/var/log/ytdsup.log`) exists, it too will be removed.
4.  Entering `yt-dl-remove -i` or `yt-dl-remove --info` in the terminal displays information about the script.

### yt-dl-update
1. Once youtube-dl has been installed by yt-dl-install, setting up yt-dl-update as a cron or anacron job can help keep youtube-dl up to date. You can set up a cron job using crontab. Alternatively, you can, as root (sudo) copy the script to `/etc/cron.daily` or `/etc/cron.monthly to be run by anacron.
```
sudo cp /path/to/yt-dl-update /etc/cron.daily
```
2. This script will update youtube-dl without leaving a log file.

### z-ytdlupdate
1. This youtube-dl update script is specifically written to be run as an anacron or cron job. If the script is in `~/bin` when yt-dl-install is run, it will be copied to `/etc/cron.daily` to be run as an anacron script.
2. This script creates a log file in `/var/log` which is limited to up to 25 entries, depending on how often youtube-dl is updated.

## Feedback:
Feel free to contact me with comments and suggestions. I can be reached through my blog, Twitter, and email.
* [GitHub](https://github.com/RickRomig/bashscripts)
* [Rick's Tech Stuff](https://ricktech.wordpress.com)
* [Twitter (@ludditegeek)](https://twitter.com/ludditegeek)
* Email: <rick.romig@gmail.com> or <rb_romig@twc.com>

Richard Romig
02 September 2019

### DISCLAIMER
THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL I BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS AND SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
