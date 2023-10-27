# default_yes

- **Purpose:** Display a yes or no (y|N) prompt that defaults to N if the Return/Enter key is pressed.

- **Argument:**: A string requiring a yes or no response.

- **Returns:** True or False

- **Notes:**
  
  - Requires either a `y` or `n` response and is case insensitive.
  
  - Pressing `Return` or `Enter`returns True.
  
  - Usage:
    
    ```bash
    if yes_or_no "Do you want to continue?"; then
        echo "Yes, I want to continue."
    else
        echo "Operation canceled. No action taken."
    fi
    ```

#### Code

```bash
default_yes() {
  while true; do
    read -rp "$* [y/n]: " yn
    case "$yn" in
      [Yy]*|'' )
        return "$TRUE"
      ;;
      [Nn]* )
        return "$FALSE"
      ;;
      * )
        printf "%s Invalid choice. Enter yes or no.\n" "$red_error" >&2
    esac
  done
}
```
