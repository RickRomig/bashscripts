# leave

1. **Purpose**: Display either a random message when exiting a script or an optional message string passed as an argument before exiting the script. The random messages are stored in `~/bin/files/leave.txt`. 

2. **Argument**:
   
   - \$1 - Optional exit message.
   
   ```bash
   leave() {
     local message="$1"
     local msg_file="$HOME/bin/files/leave.txt"
     [[ -z "$message" ]] && message=$(shuf -n 1 "$msg_file")
     printf "%s\n" "$message"
     exit 0
   }
   ```
