# is_systemd

1. **Purpose:** Returns true is the init system is systemd.

2. **Arguments:** None

3. **Returns:** True or False

```bash
is_systemd() {
 # [ -d /run/systemd/system ] && return "$TRUE" || return "$FALSE"
 SYSD=$(ps -p 1 | awk '/1 ?/ {print $4}')
 [ "$SYSD" = systemd ] && return "$TRUE" || return "$FALSE"
}
```
