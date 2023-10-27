# edit_view_quit

1. **Purpose**:  Edit or view a file after it's been created by a script.

2. **Arguments**:

   - \$1 - the file to be edited or viewed.

```bash
edit_view_quit() {
  local FILE="$1"
  echo -e "\nYou may edit or view $FILE at this time.\n"
  PS3="Choose an option: "
  select OPT in Edit View Quit
  do
    case $REPLY in
      1 ) if exists micro; then /usr/bin/micro "$FILE"; else /bin/nano "$FILE"; remove_tilde; fi; break ;;
      2 ) if exists bat; then /usr/bin/bat "$FILE"; else viewtext "$FILE"; fi; break ;;
      3 ) echo $'\n'$"Exiting."; break ;;
      * ) echo -e "\e{33mInvalid choice. Try again.\e[0m" >&2 ;;
    esac
  done
}
```

**Notes:**

1. Any text editor (vim, emacs, etc.) can be substituted for nano
2. By default, the script uses bat (if installed) to display the contents of the file. Otherwise, it will use less or cat depending how how many lines are in the file to be read.
3. bat can be downloaded from: [GitHub]([https://github.com/sharkdp/bat/releases/](https://github.com/sharkdp/bat/releases/).
4. less or cat can be substituted for bat
5. The entire if-then-else structure under the View case can be replaced by the viewtext function.
