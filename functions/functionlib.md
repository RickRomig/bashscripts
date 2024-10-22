# functionlib

### Introduction

1. **Functionlib** is a library of functions that can be incorporated into Bash scripts.

2. This library can be incorporated by sourcing it at the beginning of your script before variables or functions are declared.

   `. /home/user/bin/functionlib` or `. functionlib`

3. You may place this library anywhere in your executable path. Suitable locations might be:

   * `/home/user/bin/functionlib` (Recommended)
   * `/home/user/.local/bin/functionlib`
   * `/usr/local/bin/functionlib` (available to all users on the system)

4. The path to the function library may be omitted as long as it is in your executable path. If it's in a location not in your path, it must be hard-coded. Using environmental variables such as `$HOME` or `$USER` will not work.

5. This library has been tested using Bash with various Debian-based Linux distributions, specifically Debian, Linux Mint, Ubuntu, MX Linux, antiX, Peppermint, and Linux Lite. The functions should work in any distribution based on Debian or Ubuntu.

6. Some functions may not be POSIX compliant and may not work in shell enviroments other than Bash.

### Global variables

Global variables are available to the script sourcing the function library.

| Variable | Purpose                                                                                                                                                                                                                                                                                     |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| TRUE=0   | Used by functions that return true or false.                                                                                                                                                                                                                                                |
| FALSE=1  | Used by functions that return true or false.                                                                                                                                                                                                                                                |
| LOCALNET | Used by the `valid_ip` function and in scripts. This variable represents the first three octets of a private Class C network (192.168.1.0). Change as required for your own network.  Will detect networks used in virtual machines using 10.0.2.0/24 and 192.168.122.0/24 (Gnome Boxes and Virt-Manager). |

| RED_ERROR | Displays "ERROR" in red text. |

| RED_WARNING | Displays "WARNING" in red text. |

### Colors

1. Global variables set to the escape sequences for text attributes, text (foreground) colors, and background colors.

2. Lowercase colors indicate the foreground color and uppercase indicates background colors.

3. The color variables should be inclosed in curly brackets to separate them from the text, for instance, `echo "${red}some text.${normal}"`

### Functions

- `die` - Displays an error message and exits the calling script with an exit code. The function takes the desired error message as its first argrument and an exit code as an optional second argument. The default exit code is 1.

- `diehard` - Displays a multi-line error message and exits the call script with an exit code of 1. The function reads the text immediately following the function call.

- `error_handler` - Displays error code and line number for a trapped error. This function should not be used in a script with functions that return an integer that is not meant to be an error, i.e., an IP address or TRUE/FALSE.

- `root_user` - Returns TRUE if the calling script is being run by the root user.

- `user_exists` - Returns TRUE if the passed user name exists in the `/etc/passwd` file.

- `sudo_login` - Prompts user for sudo password if a member of the sudo group. Otherwise, displays an "Access denied" message and exists the running script. Prompt line is blanked out after a number of seconds passed to the function.

- `bin_in_path` - Returns TRUE if the `$HOME/bin` directory is in the user's PATH. This a test to check if `.profile` has been sourced or the `.bashrc` has been modified to update the PATH.

- `exists` - Returns TRUE if the passed command or program is installed.

- `get_distribution` - Sets the full name of the current distribution to global variable 'distro'. The variable must be set in the calling script before the function is called.

- `is_debian` - Returns TRUE if the distribution being run is Debian or Debian-based (i.e., Debian, Linux Mint Debian Edition, MX Linux, antiX).

    - MX 19 and antiX Linux (and newer) will be identified as Debian by the function. If you need to specifically check for MX or antiX, use the `antix_mx` function.

    - MX Linux 18 will be identified as MX.

- 'debian_based` Returns TRUE if the distribution is a Debian derivative.

- `is_focal` - Returns TRUE if the distribution is based on Ubuntu 20.04 LTS (Focal Fossa), including Linux Mint 20. Ubuntu 20.04 made significant changes to Python support and Snaps.

- `is_jammy` - Returns TRUE if the distribution is based on Ubuntu 22.04 (Jammy Jellyfish) including Linux Mint 21.

- `is_noble` - Returns TRUE if the distribution is based on Ubuntu 24.04 (Noble Numbat) including Linux Mint 22.

- `support_ppa` - Returns TRUE if the distribution being run is based on Ubuntu and supports Ubuntu Personal Package Archives (PPA).

- `antix_mx` - Returns TRUE if the distribution being run is either antiX or MX Linux. Both will return TRUE with `is_debian` but these distributions may have characteristics and functionality not found other Debian-based distributions. such as SysV init and Conky.

- `bunsenlabs` - Returns TRUE if the distribution being run is a version of Bunsen Labs Linux. The `is_debian` function will also return TRUE for a Bunsen Labs distribution, but the distribution may have characteristics and functionality not found other Debian-based distributions.

- `is_arch` - Returns TRUE if the distribution is based on Arch Linux.

- `is_systemd` - Returns TRUE if the init system used is systemd.

- `is_sysv` - Returns TRUE if the init system used is SysV.

- `is_openrc` - Returns TRUE if the init system used is OpenRC.

- `is_runit` - Returns TRUE if the init system used is Runit.

- `is_cinnamon` - Returns TRUE if the system in running the Cinnamont desktop environment.

- `is_i3wm` - Returns TRUE if the window manager is i3wm.

- `is_xfce` - Returns TRUE if the desktop environment is Xfce.

- `is_laptop` - Returns TRUE if the system is a laptop.

- `leapyear` - Returns TRUE if the 4-digit year passed to the function is a leap year. Otherwise, returns FALSE.

- `local_ip` - Extracts the last octet of  the active network interface's IP address. If the wired and wireless interfaces are both active, then the last octet of the  IP address of the wired interface is returned. If there is no IP address detected on any network interface,  the function will exit the script and display an error message.

- `valid_ip` - Takes the last octet of a local IP address as an argument and determines if it belongs to a valid and reachable IP address on the local network. If it is, 0t is returned. Otherwise, an error message is displayed and the script exits with a corresponding exit code.

- `edit_view_quit` - Takes a text file as an argument and gives the user the option of editing the file with `nano` (or your prefered editor), viewing the file with the `bat` utlity, or exiting from the function. If `bat` is not installed, `less` or`cat` is called by the `viewtext` function.

- `viewtext` - Takes a text file as an argument and displays the file using either `less` or `cat`. If the number of lines in the file is greater than 90% of the rows in the terminal, `less` will be used, otherwise `cat` is used.

- `remove_tilde` - Removes backup files with a tilde (~) appended to the file name in the current working directory.

- `check_for_file` - Checks for a file needed by the script in `~/bin/files`.

- `anykey` - "Press any key to continue."

- `print_line` - Prints a single character to a given length passed to the function.

    - The character to be printed is passed as the first argument to the function, defaulting to '=' if no argument is passed. If the argument contains more than one character, only the first character is accepted.  The character must be enclosed in double quotation marks.

    - By default, the length of the printed line is equal to the number of columns in the terminal at the time the function is executed. Optionally, a specific line length can be passed as a second argument.

    - Example: `print_line "*" 10` prints a line consisting of  10 asterisks.

- `box` - Displays a box of asterisks (or another character) around a line of text passed to the function.

    - The line of text is passed as the first argument.

    - The character to form the box is passed as the second argument to the function, defaulting to "\*" if no argument is passed. If the argument contains more than one character, only the first character is accepted. The character must be enclosed in double quotation marks.

- `under_line` - Displays a line of characters under a line of text.

    - The line of text is passed as the first argument.

    - The character to form line under the text is passed as the second argument to the function, defaulting to "\-" if no argument is passed. If the argument contains more than one character, only the first character is accepted. The character must be enclosed in double quotation marks.

- `over_line` - Displays a line of characters over a line of text.

    - The line of text is passed as the first argument.

    - The character to form line under the text is passed as the second argument to the function, defaulting to "\-" if no argument is passed. If the argument contains more than one character, only the first character is accepted. The character must be enclosed in double quotation marks.

- `leave` - Exits the script with a random message. An optional message string can be passed to the function as an argument. The random messages are stored in `~/bin/files/leave.txt`.

- `format_time` - Takes the `SECONDS` environment variable as its argument and displays the elapsed time of a running script in hours\:minutes\:seconds format. Set the `SECONDS` variable to 0 before the activity to be timed and pass `$SECONDS` to the function at the end of the activity.

- `check_package` - Takes the name of a package as its argument and determines if the package has been installed. If the package hasn't been installed, it uses `apt` to install it.

- `check_packages` - Takes an array of package nemes as its argument and determines if the packages have been installed. Any packages that are not installed, are installed usng `apt`.

- `in_repos` - Checks to see if the package name passed to it is in the distribution's repositories. Returns TRUE if the package is in the repositories, FALSE if it is not.

- `mount_server`` - Mounts an SSHFS share for the HP 6005, IP 192.168.0.18, for the purpose of installing scripts, software pacakges, and configuration files.

- `unmount_server` - Unmounts the HP 6005 SSHFS server. Also removes temporary directory (tmp_dir) and temporary file (tmp\_file).

- `mount_nas` - Mounts an SSHFS share for the NAS (Network Area Storage) on the local network.

- unmount_nas` - Unmounts the NAS and removes temporary directories and files assigned to it.

- `clone_repo` - Clones a repository from the local Gitea server to the \~/Downloads directory.

- `dots` - Displays a series of dots to indicate the passage of time while a task is running. The function should be run as a background process and its process should be killed once the task is completed. See dots-spin.md for usage example.

- `spin` - Displays a 'spinning' character to indicate the passage of time while a task is running. The function should be run as a background process and it's process should be killed once the task is completed. See dots-spin.md for usage example.

- `y_or_n` - Displays a yes or no prompt, requiring a repsonse of Y or N (case insensitive).

- `yes_or_no` - Displays a yes or no prompt, requiring a repsonse of yes or no (case insensitive).

- `default_yes` - Displays a yes or no prompt, requiring a repsonse of Y or N (case insensitive). If Enter is pressed, defaults to Yes.

- `default_no`- Displays a yes or no prompt, requiring a repsonse of Y or N (case insensitive). If Enter is pressed, defaults to No.

- `is_url_good` - Returns TRUE if the URL passed to the function is valid and reachable.

Richard B. Romig, *The Luddite Geek*
22 October 2024

* [Gitea](http://192.168.0.16:3000/)
* [GitHub](https://github.com/RickRomig/)
* [Rick's Tech Stuff](https://ricktech.wordpress.com)
* [Twitter (@ludditegeek)](https://twitter.com/ludditegeek)
* **Email:** [rick.romig@gmail.com](mailto:rick.romig@gmail.com) or [rick.romig@mymetronet.net](mailto:rick.romig@mymetronet.net)

### DISCLAIMER

THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL I BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS AND SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
