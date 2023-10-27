# root_user

1. **Purpose**: Returns true if the script is being executed by the root user, 
   false if not.
   
   ```bash
   root_user() {
     [[ "$(id -u)" -eq "0" ]] && return "$TRUE" || return "$FALSE"
   }
   ```
