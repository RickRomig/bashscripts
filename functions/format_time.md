# format_time

1. **Purpose**: Display the elasped time for the running of a script

2. **Arguments**
   
   - \$1 - SECONDS (environmental variable)
   
   ```bash
   format_time()
   {
    ET=$1
    ((h=$ET/3600))
    ((m=($ET%3600)/60))
    ((s=$ET%60))
    printf "%02d:%02d:%02d\n" $h $m $s
   }
   ```

3. **Usage**
   
   ```bash
   SECONDS=0
   # Contents of the script...
   echo "Script completed in $(format_time $SECONDS)"
   ```

```

```
