# die

1. **Purpose**: Display an error message and exits with an error code.

2. **Arguments**:
   
   - $1 -> Message
   
   - $2 -> Exit status (optional)

3. The default exit code is 1 but can be overridden by a second argument.

```bash
function die()
{
 local msg="$1" # message
 local es=${2-1} # default exit status 1
 echo -e "\e[1;31m$msg\e[0m" >&2
 exit "$es"
}
```
