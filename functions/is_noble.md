# is_nobel

1. **Purpose**: Check if a distribution is based on Ubuntu 24.04 (Noble Numbat), such as Linux Mint 22.

2. None

3. **Returns**: TRUE (0) is the distriibution is Ubuntu 24.04 or based on it, otherwise returns FALSE (0).

### Code
```bash
is_noble() {
  [[ $(awk -F= '/UBUNTU_CODENAME/ {print $NF}' /etc/os-release) == "noble" ]] && return "$TRUE" || return "$FALSE"
}
```
