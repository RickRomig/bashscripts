# exists function

1. Purpose; Returns true if the program exists (is installed), false if it does not.

2. Arguments:
   
   - \$1 - the program/command to be checked.

```bash
exists()
{
  command -v "$1" >/dev/null 2>&1 && return 0 || return 1
}
```

### Usage:

```bash
if exists <command>
  echo "<command> is installed."
else
  sudo apt install <command>
fi

exists <command> && echo "Installed" || echo "Not installed."
```

### functionlib:

```
declare -r TRUE=0
declare -r FALSE=1

function exists()
{
  command -v "$1" > /dev/null 2>&1 && return "$TRUE" || return "$FALSE"
}
```
