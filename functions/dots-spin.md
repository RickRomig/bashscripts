# dots-spin

### Dots

1.  **Purpose:** Display dots as a background process while waiting for an action to complete.

2. **Function**

   ```bash
   dots() {
      local char="${1:-.}"
      local len="${#char}"
      (( len > 1 )) && char=${char::1}
      tput civis
      while true; do echo -n "."; sleep 0.2; done &
   }
   ```

3. **Usage**

   ```bash
   echo -n "Downloading update..."
   dots
   wget -q -P "$tmp_dir" "$url/$package"
   kill "$!"
   echo ""
   tput cnorm
   ```

### spin

1. **Purpose**: Display a spinning character as a background process while waiting for an action to complete.

2. **Function**

   ```bash
   spin() {
      spinner=( '|' '/' '-' '\' )
      while true; do for i in "${spinner[@]}"; do echo -ne "\r$i"; sleep 0.2; done; done &
   }
   ```

3. **Usage**

   ```bash
   echo "Downloading update."
   spin
   wget -q -P "$tmp_dir" "$url/$package"
   kill "$!"
   echo ""
   tput cnorm
  ```
