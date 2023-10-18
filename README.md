# BASH Scripts

I've been writing script for quite a while, mostly for my own edification and amusement. Often a script will come into being as a solution to a particular problem or to automate a task. I started out with DOS batch files and more recently Bash scripts. I've dabbled in several programming languages, but I haven't done much actual programming since my college days. I'm not a scripting expert or guru by any means. I'm always learning, and I'm always looking for ways to improve my scripts. To paraphrase Paul Valéry, the French poet, "A script is never finished, only abandoned."

I have a git server on my home network where I keep my scripts and other source code, but I share certian scripts that I feel might be useful to others on my GitHub account.

I maintain a small home network of about a dozen desktops and laptops. Most of them are older machines, some more than 10 years old. I generally don't get rid of a computer if I can get some use out of it. All of them are running Debian-based operating system (Debian, Linux Mint, and LMDE). Most of the scripts in this repository should run under other distributions, but may require a few tweaks.

All the scripts are licensed under the Gnu Public Licence, v2.0. Feel free to download and use them if you find them useful. Modify them to fit your own use cases. I don't ask that you send me any changes you make, but if you find a way to make them better, I'd appreciate you sharing them with me.

### The Scripts
- **battery-check** - Displays charge and health status of a laptop battery. Pulls its data from files in /sys/class/power_supply/BAT?.
- **check-battery** - Displays charge and health status of a laptop battery using the upower utility.
- **check-updates** - Check for updates using apt-get or nala. With apt-get, provides a menu to install updates, clean apt cache, remove orphaned apps, or defer the update. If flatpak is installed, updates flatpak apps.
- **functionlib** - A library of useful functions that can be sourced by a script.
- **ip-info** - Displays IP address information for wired and wireless connections to include MAC addresses, DNS addresses, and default gateway.
- **locale-fix.sh** - changes locale-gen to store locales in individual locale direectories instead of a single archive file.
- **pwfeedback** - Enables/disables password feedback when typing password at the comand line.
- **rename-host** - Rename the system's hostname, based on a set of rules.
- **ren-ext** - Rename capitalized, mixed capitalization, and non-standard file extensions.
- **ren-space** - Replaces spaces in a file name with underscores.
- **set-resume** - Sets the RESUME environment variable with the UUID of the swap partition.
- **system-info** - Displays system information in an easy-to-read format.
- **upper2lower** - Changes filenames to all lowercase.

### Feedback:

Feel free to contact me with comments and suggestions. I can be reached through my blog, Twitter, and email.

* [GitHub](https://github.com/RickRomig/bashscripts)
* [Rick's Tech Stuff](https://ricktech.wordpress.com)
* [Twitter (@ludditegeek)](https://twitter.com/ludditegeek)
* Email: [rick.romig@gmail.com](mailto:rick.romig@gmail.com) or [rick.romig@mymetronet.net](mailto:rick.romig@mymentronet.net)

Rick Romig (*The Luddite Geek*)

17 October 2023

### DISCLAIMER

THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL I BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS AND SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
