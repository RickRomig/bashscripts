# BASH Scripts

I developed the following scripts fix problems or accomplish routine but tedious tasks. Many of the scripts I create are for specific problems or tasks but I felt that these might be of use to others. It should be noted that these scripts were written for Linux Mint but they should work for most Ubuntu and Debian distributions.

### chkupdates
1. Updates the list of available packages then displays the number of updated packages that are available. If any updates are avalilable, they are listed.

2. Root (sudo) privileges are necessary for apt-get update.

3. I find it useful to check for updates when accessing a remote system via SSH. Of course, the script needs to be on the remote system.

### getinfo
1. Gathers system information and writes it to a file in the user's home directory. The file includes the following information:

> - System manufacturer
> - System product name, version, and serial number.
> - Operating System
> - Amount of physical memory
> - CPU model
> - Graphics adapter
> - Network adapters (wired and wireless) with device names
> - Power information (battery information)
> - Hard disk information (model, serial number, and capacity)
> - Partition information from lsblk

2. The file name is the hostname with an extension of .info and is created in the user's home directory. After the information is written to the file, it is displayed using the cat command.

3. Root (sudo) privileges are required since it uses dmidecode and hdparm to extract some of the system data.

4. The dmidecode command may return errors on some systems which will be written to the file despite having STDERR redirected to /dev/null. I've only seen this on my Lenovo desktop PC when running Linux Mint 18.x (Ubuntu 16.04). These error messages can be safely ignored and can be removed from the resulting file with any text editor.

### locale-fix.sh
1. Fixes an error that sometimes occurs with update-initramfs during an update and the following awarning appears:
>Warning: No support for locale: us_US.UTF-8
>
>The problem is that /usr/share/initramfs-tools/hooks/root_locale is expecting to see individual locale directories in /usr/lib/locale, but locale-gen is configured to generate an archive file by default.

2. On Linux Mint systems (and probably other Ubuntu-based distributions) locale information is often stored in a single archive and can't be read by update-initramfs. The fix is to purge the existing locales and to store them in individual directories instead of in an archive then run update-initramfs with the -u and -t flags.

### ren-ext
1. Uses rename to rename certain file extensions in a directory to conform to a systematic naming convention. The extension to be rename is passed as a command line argument.

2. Sometimes when files are downloaded they sometimes have file extensions that are in all caps or using an alternative extension. The script renames the extensions to lowercase and in a more conventional form.

3. The following file extensions are supported:

> - BAK is renamed to bak
> - GIF is renamed to gif
> - htm, HTM, HTML are renamed to html
> - jpeg, JPG are renamed to jpg
> - MP3, MP4 are renamed to mp3 and mp4 respectively
> - PDF is renamed to pdf
> - PNG is renamed to png
> - TXT is renamed to txt

4. The scripts checks to see if an argument has been passed and if any files with that extension exist in the directory. It uses a case statement to check the passed argument against the support extensions. If a test fails, an error message is displayed along with the proper syntax.

### renspace
1. Uses rename to replace spaces in filenames with underscores. When run, the scripts renames every filename containing spaces in the current directory.

### rmtilde
1. Removes backup files in a directory that have a trailing tilde (~).

2. I wrote this script after accidentally deleting an entire directory while attempting to type rm *~.

### upper2lower
1. Uses rename to change uppercase filenames in a directory to lowercase.

2. This script, when run without a filename as an argument, it asks for confirmation before running proceeding. If the action is confirmed, it changes every instance of a capital letter in all filenames in the current directory to lowercase. Pressing any key but 'Y' will cancel the script and usage instructions will be displayed.

3. If the script is run against a specific file, it checks to be sure it exists.

### Feedback:

Feel free to contact me with comments and suggestions.

I can be reached through my blog, Twitter, and email.

>[Rick's Tech Stuff](https://ricktech.wordpress.com)
>
>[Twitter (@ludditegeek)](https://twitter.com/ludditegeek)
>
>Email: <rick.romig@gmail.com> or <rb_romig@twc.com>

Richard Romig
11 January 2019


### DISCLAIMER

THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL I BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS AND SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
