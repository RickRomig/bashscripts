# remove_tilde

1. Purpose: Remove backup files appended by a tilde in the current directory.

```
function remove_tilde()
{
  NBU=$(find ./ -maxdepth 1 -type f -name \*~  | wc -l)
  (( NBU > 0 )) && find . -maxdepth 1 -type f -iname \*~ -exec rm {} \;
}
```
