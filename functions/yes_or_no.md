# yes_or_no

- **Purpose**: Displays a yess or no prompt (yes|no).

- **Aruments**: A string requiring a yes or no response.

- **Returns**: True or False

- **Notes**:
  
  - Requires either a `y` or `n` response and is case insensitive.
  
  - Pressing `Return` or `Enter` displays a warning that a response is required.
  
  - A reponse beginning with anything but `yes` or `no` generates an invalid response message.
  
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
yes_or_no() {
  while true; do
    read -rp "$* [yes/no]: " yesno
    case "${yesno,,}" in
      yes )
        return "$TRUE"
      ;;
      no )
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
