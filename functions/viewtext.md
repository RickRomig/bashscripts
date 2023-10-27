# viewtext

1. **Purpose**: View a text file in a terminal, automatically choosing cat or less depending on the number of lines in the files and the number of rows in the terminal window. Whether less or cat is used to display the file is based on the ratio of number of lines in the file to the number of rows in the local terminal. If the number of the lines is greater than 90% of the number of terminal rows, less is used, otherwise cat.

2. Argument:
   
   - \$1 - file to be viewed.
   
   ```bash
   viewtext()
   {
     local FILE="$1"
     TROWS="$(tput lines)" # Number of rows in the local terminal
     NLINES=$(wc -l "$FILE" | cut -d " " -f1) # Number of lines in the file
    LC=$(( TROWS*90/100 ))
    (( NLINES > LC )) && /usr/bin/less "$FILE" || /bin/cat "$FILE"
   }
   ```

```

```
