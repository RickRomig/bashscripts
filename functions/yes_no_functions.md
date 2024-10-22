# Yes or No functions

1. **Purpose**: Prompt for a yes or no response.

2. **Arguments**: A prompt requiring a y/n or yes/no response.

3. **Returns**: TRUE (0) for a y or yes response, otherwise FALSE (0).

### Notes
- Of these functions, only `yes_or_no` requires the full word to be enter. Otherise y or n is sufficient.
- Responses are case insensitive.
- With `default_yes` and `default_no`, pressing the Enter key will default to either y or n, respectively

### Code
```bash
y_or_n() {
  local yn yn_prompt
  yn_prompt="$1"
  while true; do
    read -rp "$yn_prompt [y/n] " yn
    case "$yn" in
      [Yy]* )
        return "$TRUE"
      ;;
      [Nn]* )
        return "$FALSE"
      ;;
      '' )
        printf "%s Response required -- try again.\n" "$RED_WARNING" >&2
      ;;
      * )
        printf "%s Invalid choice. Enter y or n.\n" "$RED_ERROR" >&2
    esac
  done
}

yes_or_no() {
  local yn yn_prompt
  yn_prompt="$1"
  while true; do
    read -rp "$yn_prompt [yes/no] " yn
    case "${yn,,}" in
      yes )
        return "$TRUE"
      ;;
      no )
        return "$FALSE"
      ;;
      '' )
        printf "%s Response required -- try again.\n" "$RED_WARNING" >&2
      ;;
      * )
        printf "%s Invalid choice. Enter yes or no.\n" "$RED_ERROR" >&2
    esac
  done
}

default_yes() {
  local yn yn_prompt
  yn_prompt="$1"
  while true; do
    read -rp "$yn_prompt [Y/n] " yn
    case "$yn" in
      [Yy]*|'' )
        return "$TRUE"
      ;;
      [Nn]* )
        return "$FALSE"
      ;;
      * )
        printf "%s Invalid choice. Enter y or n.\n" "$RED_ERROR" >&2
    esac
  done
}

default_no() {
  local yn yn_prompt
  yn_prompt="$1"
  while true; do
    read -rp "$yn_prompt [y/N] " yn
    case "$yn" in
      [Yy]* )
        return "$TRUE"
      ;;
      [Nn]*|'' )
        return "$FALSE"
      ;;
      * )
        printf "%s Invalid choice. Enter y or n.\n" "$RED_ERROR" >&2
    esac
  done
}
```
