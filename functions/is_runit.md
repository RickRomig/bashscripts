# is_runit

1. **Purpose:** Returns true if the init system is Runit.

2. **Arguments**: none

3. **Returns**: True or False

```bash
is_runit() {
  [[ $(cat /proc/1/comm) == "runit" ]] && return "$TRUE" || return "$FALSE"
}
```
