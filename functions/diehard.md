# diehard

1. **Purpose:** Display a multi-line error message (1 or more lines) and exit with an error code of 1.

2. **Arguments:** None but the lines to be displayed will immediately follow the call to the function.

3. **Example:**
   
   ```bash
   diehard "File does not exist." "Please check your spelling."
   
   ERROR: File does not exist.
   Please check your spelling.
   ```

```bash
diehard() {
    printf "\e[91mERROR:\e[0m "
    exec 2>&1; for line; do echo "$line"; done; exit 1
}
```
