# is_openrc

1. **Purpose:** Returns true if the init system is OpenRC.

2. **Arguments**: none

3. **Returns**: True or False

```bash
is_openrc() {
  [[ -f /sbin/openrc ]] && return "$TRUE" || return "$FALSE"
}
```
