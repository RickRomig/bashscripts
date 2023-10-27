# get_distribution

1. **Purpose**: Display the full name of the installed Linux distribution.
2. Returns nothing.

### functionlib
```bash
get_distribution() {
  if [[ -f /etc/lsb-release ]]; then
    distro=$(awk -F= '/DISTRIB_DESCRIPTION/ {print $NF}' /etc/lsb-release | sed 's/"//g')
  else
    distro=$(lsb_release -d | cut -f 2)
  fi
  echo "$distro"
}
```

### Usage
```bash
echo "Distribution is $(get_distribution)"
```

### Notes
1. In many Debian-based distributions the file `/etc/lsb-release` does not exist, so the function will obtain the distribution name from the `lsb_release` command.
2. Tested with Debian 10 & 11, Antix, MX Linux 19 & 21, and BunsenLabs Lithium.
