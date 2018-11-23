# BASH Scripts

I developed the following scripts fix problems or accomplish routine but tedious tasks. Many of the scripts I create are for specific problems or tasks but I felt that these might be of use to others.

### getinfo
1. Gathers system information and writes it to a file in the user's home directory. The file includes the following information:
 - System manufacturer
 - Syste product name, version, and serial number.
 - Operating System
 - Amount of physical memory
 - CPU model
 - Graphics adapter
 - Network adapters (wired and wireless) with device names
 - Power information (battery information)
 - Hard disk information (model, serial number, and capacity)
 - Partiion information from lsblk

2. The file name is the hostname with an extension of .info and is created in the user's home directory. After the information is written to the file, it is display using the cat command.

3. Root (sudo) privileges are required since it uses dmidecode and hdparm to extract some of the system data.

### locale-fix.sh
1. Fixes an error that sometimes occurs when update-initramfs during an update and the following awarning appears:
 >Warning: No support for locale: us_US.UTF-8

 >The problem is that /usr/share/initramfs-tools/hooks/root_locale
 is expecting to see individual locale directories in /usr/lib/locale,
 but locale-gen is configured to generate an archive file by default.

2. On Linux Mint systems (and probably other Ubuntu-based distributions) locale information is often stored in a single archive and can't be read by update-initramfs. The fix is to purge the existing locales and to store them in individual directories instead of in an archive then run update-initramfs with the -u and -t flags.

### ren-ext
1. Uses rename to rename certain file extensions in a directory to conform to a systematic naming convention. The extension to be rename is passed as a command line argument.

2. Sometimes when files are downloaded they sometimes have file extensions that are in all caps or using an alternative extension. The script renames the extensions to lowercase and in a more conventional form.

3. The following file extensions are supported:
 - BAK is renamed to bak
 - GIF is renamed to gif
 - htm, HTM, HTML are renamed to html
 - jpeg, JPG are renamed to jpg
 - MP3, MP4 are renamed to mp3 and mp4 respectively
 - PDF is renamed to pdf
 - PNG is renamed to png
 - TXT is renamed to txt

4. The scripts checks to see if an argument has been passed and if any files with that extension exist in the directory. It uses a case statement to check the passed argument against the support extensions. If a test fails, an error message is displayed along with the proper syntax.

### renspace
1. Uses rename to replace spaces in filenames with underscores. When run, the scripts renames every filename containing spaces in the current directory.

### rmtilde
1. Removes backup files in a directory that have a trailing tilde (~).

2. I wrote this script after accidentally deleting an entire directory while attempting to type rm *~. While reaaching for the ~ key, my finger missed the shift key and hit the Enter key, deleting the entire directory. Fortunately, I had a recent backup and I was able to restore my files.

### upper2lower
1. Uses rename to change uppercase filenames in a directory to lowercase.

2. This script, when run without a filename as an argument, can change every instance of a capital letter in a filename in the directory to lowercase so it will ask for confirmation before running against the entire directory. Pressing any key but 'Y' will cancel the script and usage instructions will be displayed.

3. If the script is run against a specific file, it will check to be sure it exists.
