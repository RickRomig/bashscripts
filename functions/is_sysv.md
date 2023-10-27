# is_sysv

1. **Purpose:** Returns true is the init system is SysV.

2. **Arguments**: none

3. **Returns**: True or False

```bash
is_sysv() {
 SYSV=$(/sbin/init --version 2>/dev/null | awk '{print $1}')
 [ "$SYSV" = "SysV" ]  && return "$TRUE" || return "$FALSE"
}
```
