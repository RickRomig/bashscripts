# box

1. **Purpose:** Displays a box of asterisks around a line of text passed to the function.

2. **Arguments:** 
   
   - A single line of text to be displayed inside the box.
   
   - A single character inside double-quotes ("\*") to form the box. An asterisk is the default character if no character is specified. If more than one character appears in the string, only the first character is used.

```bash
box() {
  char="${2:-*}"
  len=${#char}
  (( len > 1 )) && char=${char::1}
  local title="$char $1 $char"
  edge=$(echo "$title" | sed "/./$char/g")
  echo "$edge"
  echo "$title"
  echo "$edge"
}
```
