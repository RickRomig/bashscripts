# is_xfce

1. **Purpose**: Check if the desktop environment is XFCE.

2. None

3. **Returns**: TRUE (0) is the window manager is XFCE, otherwise returns FALSE (0).

### Code
```bash
is_xfce() {
  [[ -f /usr/bin/xfce-session ]] && return "$TRUE" || return "$FALSE"
}
```
