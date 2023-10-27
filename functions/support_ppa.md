# support_ppa function

1. **Purpose**: Return true if the distribution supports Ubuntu Personal Package Archives (PPA).

### functionlib

```bash
declare -r TRUE=0
declare -r FALSE=1

support_ppa() {
  codename=$(lsb_release -c | cut -f 2)
  case $codename in
    bionic|focal|tricia|uma|una ) return "$TRUE" ;;
    * ) return "$FALSE" ;;
  esac
}

# Old version
support_ppa() {
  distro=$(/usr/bin/lsb_release -d | /usr/bin/awk '{print $2}')
  [ "$distro" = "Linux" ] && distro=$(/usr/bin/lsb_release -d | /usr/bin/awk '{print $3}')
  case $distro in
    Lite|Mint|Peppermint|Ubuntu ) return "$TRUE" ;;
    * ) return "$FALSE" ;;
   esac
}
```

### Usage in a script

```
if support_ppa; then
  echo "Ubuntu Personal Package Archives (PPA) supported."
else
  echo "Ubuntu Personal Package Archives (PPA) not supported." >&2
  exit 1
fi
```

**Notes**

1. New cases should be added for other distributions that support Ubuntu Personal Package Archives (PPA).
