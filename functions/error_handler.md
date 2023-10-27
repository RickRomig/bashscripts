# error_handler

1. **Purpose:** Displays error code and line number for a trapped error.

2. **Arguments:** Error code and line number returned by the trap builtin.

3. **Notes:**
   
   - This function should not be used in a script with functions that return an integer that is not meant to be an error, i.e., an IP address or TRUE/FALSE.

4. **Example:**
   
   ```bash
   trap 'error_handler $? $LINENO' ERR
   
   sudo apt fnloc
   Reading package lists... Done
   Building dependency tree       
   Reading state information... Done
   E: Unable to locate package fnloc
   ERROR: (100) occurred on line 42
   ```

```bash
error_handler() {
  printf "\e[91mERROR:\e[0m (%s) occurred on line %s\n" "$1" "$2" >&2
  exit "$1"
}

trap 'error_handler $? $LINENO' ERR
```


