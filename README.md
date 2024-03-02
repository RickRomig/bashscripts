# BASH Scripts

### Introduction
I've been writing script for quite a while, mostly for my own edification and amusement. Often a script will come into being as a solution to a particular problem or to automate a task. I started out with DOS batch files and more recently Bash scripts. I've dabbled in several programming languages, but I haven't done much actual programming since my college days. I'm not a scripting expert or guru by any means. I'm always learning, and I'm always looking for ways to improve my scripts. To paraphrase the French poet, Paul Valéry, "*A script is never finished, only abandoned.*"

I have a git server on my home network where I maintain my scripts and other source code. Most of those scripts are specific to my network but I'm sharing many of the general purpose scripts that I feel might be useful to others on my GitHub account. In the future, I plan to add some of my instalallation scripts for various applications once I adapt them for general use.

I maintain a small home network of about a dozen desktops and laptops. Most of them are older machines, some more than 10 years old. I generally don't get rid of a computer if I can get some use out of it. All of them are running Debian or Ubuntu based operating systems (Debian, Linux Mint, and LMDE). Most of the scripts in this repository should run under other distributions, but may require a few modifications.

### Function library
Many of the scripts in this repository source the `functionlib` script which contains various functions and global variables. I recommend having this script in your `~/bin` directory or in your user path. If you place in a directory other than `~/bin`, you need to change the scripts with the new path to the library. Another alternative would be to cut and paste the necessary functions and global variables into the scripts as required.

The `functions` directory contains markdown files explaining each of the function in `functionlib`.

### License
All the scripts are licensed under the Gnu Public Licence, v2.0. Feel free to download and use them if you find them useful. Modify them to fit your own use cases. I don't ask that you send me any changes you make, but if you find a way to make them better, I'd appreciate you sharing them with me.

### The Scripts
**Note:** Many of these scripts source `functionlib` which should be available in your ~/bin directory or in your path.
- **battery-check** - Displays charge and health status of a laptop battery. Pulls its data from files in `/sys/class/power_supply/BAT?`.
- **catless** - Displays a text file using either cat or less, depending on the size of the file and the number of lines in the current display.
- **check-battery** - Displays charge and health status of a laptop battery using the upower utility.
- **check-updates** - Check for updates using apt-get or nala. With apt-get, a menu offers options to install updates, clean apt cache, remove orphaned apps, or defer the update. If flatpak is installed, it updates flatpak apps.
- **checkinit** - Reports the init system being used (Systemd, SysV, Runit, or OpenRC).
- **check-versions** - Displays current and installed versions of certain packages from GitHub and installed versions of packages installed via `apt`. Can be edited for specific packages. GitHub packages generally follow the same format on their releases page. Gitlab may have a different format.
- **cinnkeys** - Creates a backup file for Cinnamon keybindings and restores keybindings from the backup.
- **empty-trash.sh** - Run as a cron job to empty the Trash directory in a user's home folder. Tested on Linux Mint, LMDE, MX Linux, BunsenLabs, Debian Cinnamon, Debian i3.
- **functionlib** - A library of useful functions and global variables that can be sourced by a script.
- **install-brave** - Installs/Removes the Brave browser.
- **install-codium** - Installs/Removes VSCodium.
- **install-firefox-deb** - Installs Firefox from the Mozilla DEB repository.
- **install-vrtmgr** - Installs virt-manager, KVM/QEMU, and associated utilities.
- **ip-info** - Displays IP address information for wired and wireless connections to include MAC addresses, DNS addresses, and default gateway.
- **iru-bat** - Installs, removes, updates the Bat utility.
- **iru-marktext** - Installs, removes, updates the Mark Text markdown editor.
- **iru-micro** - Installs, removes, updates the Micro CLI text editor. Includes basic settings and an additional keybinding.
- **laptop-utils** - Installs utilities for power-management and other services on a laptop.
- **laptoplid** - Modifies `/etc/systemd/logind` to allow a laptop's lid to be closed without going into suspend mode.
- **locale-fix.sh** - changes locale-gen to store locales in individual locale direectories instead of a single archive file.
- **no-flatpak** - Enables/Disables Flatpak in Debian/Ubuntu systems.
- **no-snaps** - Enables/Disables Snaps in Debian/Ubuntu systems.
- **purge-image-rc** - Purges obsolete packages (Linux headers and images) in the remove/deinstall state with only configuration files installed.
- **pwfeedback** - Enables/disables password feedback when typing password at the comand line.
- **rename-host** - Rename the system's hostname, based on a set of rules.
- **ren-ext** - Rename capitalized, mixed capitalization, and non-standard file extensions.
- **ren-space** - Replaces spaces in a file name with underscores.
- **show-cron** - Displays anacron jobs and crontabs for users and root.
- **set-resume** - Sets the RESUME environment variable with the UUID of the swap partition.
- **system-info** - Displays system information in an easy-to-read format.
- **system-status** - Displays a snapshot of CPU, memory, & disk usage, as well as system temperatures and uptime.
- **upper2lower** - Changes filenames to all lowercase.
- **verify-iso** - Verifies checksums for downloaded ISO files.
- **write-iso** - Writes ISO files to USB drive using `dd`. Lists available ISO files in the current directory and attached USB drives.

### Feedback:

Feel free to contact me with comments and suggestions. I can be reached through my blog, Twitter, and email.

* [GitHub](https://github.com/RickRomig/bashscripts)
* [Rick's Tech Stuff](https://ricktech.wordpress.com)
* [Twitter (@ludditegeek)](https://twitter.com/ludditegeek)
* Email: [rick.romig@gmail.com](mailto:rick.romig@gmail.com) or [rick.romig@mymetronet.net](mailto:rick.romig@mymentronet.net)

Rick Romig (*The Luddite Geek*)

02 March 2024

### DISCLAIMER

THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL I BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS AND SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
