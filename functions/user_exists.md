# user_exists

1. **Purpose**: Returns true if the user passed to the function exists in `/etc/passwd`, 
   false if not.

2. **Argument**:
   
   - \$1 (username) -> Username to check in `/etc/passwd`
   
   ```bash
   user_exists() {
     local U="$1"
     local passwd_file="/etc/passwd"
     grep -q "^${U}" $passwd_file && return "$TRUE" || return "$FALSE"
   }
   ```
