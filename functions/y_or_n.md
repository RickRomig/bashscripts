# y_or_n

- **Purpose**: Displays a yess or no prompt (y|n).

- **Arguments**: A string requiring a yes or no response.

- **Returns**: True or False

- **Notes**
  
  - Requires either a `y` or `n` response and is case insensitive.
  
  - Pressing `Return` or `Enter` displays a warning that a response is required.
  
  - A reponse beginning with anything but a `y` or `n` generates an invalid response message.
  
  - Usage:
    
    ```bash
    if y_or_n "Do you want to continue?"; then
        echo "Yes, I want to continue."
    else
        echo "Operation canceled. No action taken."
    fi
    ```

#### Code

```bash
y_or_n() {
  while true; do
    read -rp "$* [y/n]: " yn
    case "$yn" in
      [Yy]* )
        return "$TRUE"
      ;;
      [Nn]* )
        return "$FALSE"
      ;;
      '' )
        printf "%s Response required -- try again.\n" "$red_warning" >&2
      ;;
      * )
        printf "%s Invalid choice. Enter yes or no.\n" "$red_error" >&2
    esac
  done
}
```
