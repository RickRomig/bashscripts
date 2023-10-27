# is_debian

1. **Purpose**: Return true if the distribution is based on Debian, otherwise returns false.

2. Returns 0 (TRUE) if Debian, LMDE, Antix, or MX Linux, otherwise returns 1 (FALSE).

### functionlib

```bash
declare -r TRUE=0
declare -r FALSE=1

is_debian() {
  codename=$(lsb_release -c | cut -f 2)
  case $codename in
    bullseye|buster|debbie ) return "$TRUE" ;;
    * ) return "$FALSE" ;;
  esac
}

# Old version
function is_debian() {
  distro=$(/usr/bin/lsb_release -d | /usr/bin/awk '{ print $2 }')
  [ "$distro" = "Linux" ] && distro=$(/usr/bin/lsb_release -d /usr/bin/awk '{ print $3 }')
  case $distro in
    Debian|LMDE|MX|BunsenLabs ) return "$TRUE" ;;
    * ) return "$FALSE" ;;
  esac
}
```
