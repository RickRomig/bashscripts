# is\_cinnamon

1. **Purpose:** Return TRUE if the active desktop environment is Cinnamon.

2. **Arguments:** None

3. **Returns:** TRUE if the Cinnamon desktop enviroment is running.

```bash
is_cinnamon() {
[ -f /usr/bin/cinnamon-session ] && return "$TRUE" || return "$FALSE"
}
```
