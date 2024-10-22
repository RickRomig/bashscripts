# debian_based

1. **Purpose**: Check if the running distribution is Debian-based (Ubuntu, Mint, BunsenLabs, antiX, MX)

2. **Arguments**: None

3. **Returns**: TRUE (0) if distributions is Debian-based, FALSE (1) if not.

### Code
```bash
debian_based() {
  local like_deb
  like_deb=$(grep -E 'ID|ID_LIKE' /etc/os-release | grep -w debian)
  [[ "$like_deb" ]] && return "$TRUE" || return "$FALSE"
}

```
