# Load function library

1. Standard version



   ```bash
   ## Shellcheck Directives ##
   # shellcheck source=/home/rick/bin/functionlib
   # shellcheck disable=SC1091

   ## Load function library ##

   if [ -x "/home/rick/bin/functionlib" ]; then
     . /home/rick/bin/functionlib
   else
     echo -e "\e[1;31mERROR:\e[0m functionlib not found!" >&2
     exit 1
   fi
   ```

2. Source from `.bashrc` for use on command line and all scripts.

   ```bash
   # Function library
   [[ -f ~/bin/functionlib ]] && ~/bin/functionlib
   ```

3. **Notes**

   - Place at the beginning of the script, after the header and license, but before any variable or function declarations.

   - The full path to the function library must be used. Variables, including environmental variables (HOME, USER) will not work.

   - Include `# shellcheck disable=SC1091` before sourcing.
