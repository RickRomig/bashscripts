# Checking arguments

There are a number of ways to check to see if any arguments have been passed to a script.

### Basic syntax

```bash
if [ -z "$1" ]; then
  echo "Error: No argument passed." >&2
  usage
else
  FILE="$1"
fi

if [ ! -e "$myfile" ]; then
  echo "Error: $FILE not found." >&2
  usage
fi
```

### Combined statements

```bash
if [ -z "$1" ]; then
  echo "Error: No argument passed." >&2
  usage
else
  FILE="$1"
  if [ ! -f "$FILE" ]; then
    echo "Error: $FILE not found." >&2
    usage
  fi
fi

if [ -z "$1" ]; then
  echo "Error: No argument passed." >&2
  usage
elif [ ! -f "$1" ]; then
  echo "Error: $1 not found." >&2
  usage
else
  FILE="$1"
fi

if [ -z "$1" ]; then
  die "No argument passed."
elif [ ! -f "$1" ]; then
  die "Error: $1 not found."
else
  FILE="$1"
fi

if [ $# -eq 0 ]; then
  echo "Error: No argument passed." >&2
  usage
elif [ ! -f "$1" ]; then
  echo "Error: $1 not found." >&2
  usage
else
  FILE="$1"
fi

if [ $# -eq 0 ]; then
  die "No argument passed."
elif [ ! -f "$1" ]; then
  die "Error: $1 not found."
else
  FILE="$1"
fi
```

### Check for no arguments passed

```bash
if [ $# -eq 0 ]; then
  echo "No argument supplied" >&2
  exit 1
fi

if [ $# -lt 1 ]; then
  echo "No argument supplied" >&2
  exit 1
fi

if [ -z "$1" ]; then
  echo "No argument supplied" >&2
  exit 1
fi
```

### Example one-liners

```bash
[ -z "$1" ] && echo "No argument supplied" >&2; exit 1
[ $# -eq 0 ] && echo "No argument supplied" >&2; exit 1

[ -z "$1" ] && usage    # usage function
[ $# -lt 1 ] && usage   # usage function

[ -z "$1" ] && die "No argument supplied"   # functionlib must be sourced
[ $# -lt 1 ] && die "No argument supplied"  # functionlib must be sourced
```

### Other cases

```bash
if [[ $# -eq 0 ]]; then
  echo "some message" &>2
  exit 1
fi
```

### Command-line options

```bash
if [[ "$#" -eq 0 ]]; then
  echo "${lightred}Error!${normal} No argument passed!" >&2; usage; exit 1
else
  case "$1" in
    --help ) echo "Help:"; usage; exit ;;
    --install ) install_package ;;
    --remove ) remove_package ;;
    * ) echo "${lightred}Invalid argument${normal}" >&2; usage; exit 1 ;;
  esac
fi
```

### Integer Arguments
```bash
if [[ "$1" =~ ^[0-9]+$ ]] 2>/dev/null; then
  echo "Argument is an integer"
fi

if [[ -n ${1//[0-9]/} ]]; then
  echo "Not an integer"
fi

if [[ -z ${1//[0-9]/} ]]; then
  echo "Argument is an integer"
fi

if [ "$1" -eq "$1" ] 2>/dev/null; then
  echo "Argument is an integer"
  # Must be single brackets. Double brackets always resolves to true.
fi
```
