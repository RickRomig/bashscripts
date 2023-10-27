# bin_in_path

1. **Purpose:** Return true if  `$HOME/bin` is in the PATH.

2. **Arguments:** None

3. **Returns:** True or False

```bash
function bin_in_path()
{
  echo "$PATH" | grep -q "$HOME/bin" && return $TRUE || return $FALSE
}
```
