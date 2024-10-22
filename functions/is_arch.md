# is_arch

1. **Purpose**: Check if the distribution is based on Arch Linux.

2. None

3. **Returns**: TRUE (0) is the distriibution is based on Arch Linux, otherwise returns FALSE (0).

### Code
```bash
is_arch() {
  [[ -d /etc/pacman.d ]] && return "$TRUE" || return "$FALSE"
}
```
