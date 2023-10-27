# print_line

1. **Purpose**: Print a line consisting of a single character.

2. **Arguments**:
   
   - \$1 - the character to be printed in the line
   - \$2 - the length of the line to be printed

3. Defaults to "=" and the full length of the terminal window if no arguments are passed.

4. The character argument must be enclosed in double quotation marks.

5. If the character argument contains more than a single character, the first character is used.

6. The second argument must be an integer value.

```bash
print_line() {
  char="${1:-=}"      # Character to be printed (= is the default).
  width=$(tput cols)  # Default line length = width of local terminal.
  if [[ "$#" -gt 1 ]]; then
    char="$1"
    width="$2"
  fi
  len=${#char}
  (( len > 1 )) && char=${char::1}    # Allow only first character.
  printf "%${width}s\n" | sed "s/ /$char/g"
}
```

**Notes**

1. The `tr` command was originally used (`tr " " "\$CHAR"`). The `sed` command replaced it because it supports unicode characters.
