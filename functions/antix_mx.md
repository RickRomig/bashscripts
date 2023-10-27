# antix_mx

1. **Purpose:** Return true if the current distribution is antiX or MX Linux.

2. **Arguments:** None

3. **Returns:** True or False

4. Specifically checks for antiX or MX Linux. The `is_debian` function will return true with either of these distributions.

```bash
function antix_mx()
{
  DIST_ID=$(grep 'DISTRIB_ID' /etc/lsb-release 2> /dev/null | cut -d '=' -f2)
  case $DIST_ID in
    antiX|MX )
      return "$TRUE" ;;
    * )
      return "$FALSE" ;;
  esac
}
```
