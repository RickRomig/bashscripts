# BASH Scripts

I usually write scripts to fix a particular problem or to accomplish a routine task. I felt that these scripts might be of use to others. It should be noted that these scripts were written in Bash for Linux Mint (18.3, 19.1, and LMDE 3) but they should work for most Ubuntu and Debian based distributions.

### chkupdates
1. Updates the list of available packages then displays the number of updated packages that are available. If any updates are available, they are listed.
2. Root (sudo) privileges are necessary for `apt`.
3. I find it very useful to for updates when accessing a remote system via SSH. Of course, the script also needs to be on the remote system.

### clean-bin
1. Cleans up the ~/bin directory by removing all backup files ending with a tilde and copying any files created or modified within the previous 24 hours to a designated folder which is set in the `$scriptfolder` variable.
2. If the script is run from anywhere other than the `~/bin` directory, it uses `pushd` to go to `~/bin` for the cleanup and then uses `popd` to return to directory from where it was launched.

### dos2linux
1. Removes DOS carriage return characters ('\r') from text files created by DOS and Windows text editors so they work better with some Linux programs. The original file is retained and appended with a .bak extension.
2. The script takes the file to be processed as an argument and checks to see if it exists. A usage message is displayed if the file doesn't exist or no argument is passed.

### ipinfo.sh
1. Displays a system's basic IP information in an easy to read format.
2. Information displayed:
 * Public IP address
 * Local (private) IP address with CIDR notation (i.e., 192.168.1.100/24)
 * Default gateway
 * DNS servers, if system has a static IP, otherwise displays the default gateway address.

### locale-fix.sh
1. Fixes an error that sometimes occurs with update-initramfs during an update and the following awarning appears:
>Warning: No support for locale: us_US.UTF-8
>
>The problem is that /usr/share/initramfs-tools/hooks/root_locale is expecting to see individual locale directories in /usr/lib/locale, but locale-gen is configured to generate an archive file by default.

2. On Linux Mint systems (and probably other Ubuntu-based distributions) locale information is often stored in a single archive and can't be read by update-initramfs. The fix is to purge the existing locales and to store them in individual directories instead of in an archive then run `update-initramfs` with the -u and -t flags.

### ren-ext
1. Uses the rename command to rename certain file extensions in a directory to conform to a systematic naming convention. The extension to be renamed is passed as a command line argument.
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
1. Uses rename to replace spaces in filenames with underscores. When run, the script renames every filename containing spaces in the current directory.

### rmtilde
1. Removes backup files with a trailing tilde (~) in the current directory.
2. I wrote this script as a safeguard to prevent accidentally deleting all the files in a directory while attempting to type `rm \*~`. Sometimes fingers slip.

### sysinfo
1. Gathers system information and writes it to a file in the user's home directory. The file includes the following information:
 * System manufacturer (dmidecode)
 * System product name, version, and serial number (dmidecode)
 * Operating System (lsb_release)
 * Amount of physical memory (/proc/meminfo)
 * CPU model ( /proc/cpuinfo)
 * Graphics adapter (lspci)
 * Network adapters (wired and wireless) with device names and MAC addresses (lspci, nmcli, /sys/class/net/)
 * Power/battery information (/sys/class/power_supply/)
 * Hard disk information - model, serial number, and capacity (hdparm)
 * Partition information (lsblk)
2. The file name is the hostname with an extension of .info and is created in the user's home directory. After the information is written to the file, it is displayed using the cat command.
3. Root (sudo) privileges are required since it uses `dmidecode` and `hdparm` to extract some of the system data.
4. The dmidecode command may return errors on some systems which will be written to the file despite having STDERR redirected to /dev/null. I've only seen this on my Lenovo M91p desktop PC when running Linux Mint 18.x (Ubuntu 16.04). These error messages can be safely ignored and can be removed from the resulting file with any text editor.

### upper2lower
1. Uses rename to change uppercase filenames in a directory to lowercase.
2. This script, when run without a filename as an argument, it asks for confirmation before running proceeding. If the action is confirmed, it changes every instance of a capital letter in all filenames in the current directory to lowercase. Pressing any key but 'Y' will cancel the script and usage instructions will be displayed.
3. If the script is run against a specific file, it checks to be sure the file exists.

### Feedback:

Feel free to contact me with comments and suggestions. I can be reached through my blog, Twitter, and email.
* [GitHub](https://github.com/RickRomig/bashscripts)
* [Rick's Tech Stuff](https://ricktech.wordpress.com)
* [Twitter (@ludditegeek)](https://twitter.com/ludditegeek)
* Email: <rick.romig@gmail.com> or <rb_romig@twc.com>

Richard Romig
31 March 2019

### DISCLAIMER
THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL I BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS AND SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
