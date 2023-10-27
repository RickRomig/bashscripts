# bunsenlabs

1. **Purpose:** Return true if the distribution is a version of a Bunsen Labs distribution.
2. **Arguments:** None.
3. **Returns:** True or False.
4. Specifically checks for a Debian-based distribution from Bunsen Labs.The `is_debian` function will return true for this distribution as it is based on Debian.

```bash
bunsenlabs() {
  distro=$(/usr/bin/lsb_release -d | /usr/bin/awk '{print $2}')
  [ "$distro" = "BunsenLabs" ] && return "$TRUE" || return "$FALSE"
}
```
