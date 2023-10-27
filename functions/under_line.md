# under_line

1. **Purpose:** Displays a line of a single character under a line of text.

2. **Arguments:** 
   
   - A single line of text.
   
   - A single character inside double-quotes ("-") to form the box. An hyphen is the default character if no character is specified. If more than one character appears in the string, only the first character is used.

```bash
under_line() {
  local title="$1"
  char="${2:--}"
  len=${#char}
  (( len > 1 )) && char=${char::1}
  line=$(echo "$title" | sed "/./$char/g")
  echo "$title"
  echo "$line"
}
```
