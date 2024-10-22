# is_i3wm

1. **Purpose**: Check if the window manager is i3wm.

2. None

3. **Returns**: TRUE (0) is the window manager is i3wm, otherwise returns FALSE (0).

### Code
```bash
is_i3wm() {
  # [[ $(wmctrl -m | awk '/Name/ {print $2}') == "i3" ]] && return "$TRUE" || return "$FALSE"
  [[ -f /usr/bin/i3-session ]] && return "$TRUE" || return "$FALSE"
}
```
