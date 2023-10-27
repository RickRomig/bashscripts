# Cleanup functions

* Cleanup tmp files/directories after exit
* The function is called by trap builtin
  
  ```bash
  cleanup()
  {
    if [ -f "$tmp_file" ]; then
      rm -f "$tmp_file"
    fi
  }
  
  cleanup(){  [ -d "$tmp_dir" ] && rm -rf "$tmp_dir"}
  ```

## Notes:

The cleanup function is called by the trap builtin as follows:

```bash
trap cleanup EXIT
```

Creating temporary files and directories

```bash
tmp_file=$(mktemp) || exit 1
tmp_file=$(mktemp) || die "ERROR: Failed to create temporary file!"
tmp_dir=$(mktemp -d) || exit 1
tmp_dir=$(mktemp -d) || die "ERROR: Failed to create temporary diectory!"
```

**Note:** The die function in functionlib exits the script with a default exit code of 1. If you want to use a different exit code, add it as a second argument to the funciton.


