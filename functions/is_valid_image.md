# is_valid_image

1. **Purpose**: Return true if a file is a valid image file, based on file extension.

2. **Argument**:
   
   - \$1 - image file to be checked.
   
   ```bash
   is_valid_image()
   {
     local FILE="$1"
     local EXT="${FILE##*.}"
     shopt -s nocasematch # Makes extension case insensitive
     case $EXT in
       bmp|gif|jpeg|jpg|png|tiff)
         shopt -u nocasematch # Turns off case insensitivity
         return "$TRUE"
         ;;
       *)
         shopt -u nocasematch # Turns off case insensitivity
         return "$FALSE"
         ;;
     esac
   }
   ```



```

```
