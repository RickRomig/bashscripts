# sudo_login

1. **Purpose:** Prompts for the sudo password if user is in the sudo group and there is not an active sudo session. Once the password is entered, the prompt line is blanked out after X seconds. If the user is not in the sudo group, an error message is displayed and the calling script exits.

2. **Arguments:** An integer indicating the number of seconds delay before the password prompt line is blanked and the script continues. A delay of 0 bypasses the delay. The password prompt line is not blanked and the script continues.

```bash
sudo_login() {
  local delay="${1:-2}"
  if id -nG "$USER" | grep -qw sudo; then
    if ! sudo -vn 2>/dev/null; then
      sudo ls > /dev/null 2>&1
      [[ "$delay" -gt 0 ]] && { sleep "$delay"; printf '\e[A\e[K'; }
    fi
  else
    die "$USER is not a member of the sudo group. Access denied."
  fi
}
```
