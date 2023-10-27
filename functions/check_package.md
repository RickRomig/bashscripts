# check_package

* **Purpose**: Checks if a package is installed and installs the package if it is not.

* **Argument**: Takes the name of the package to be checked/installed.

```bash
function check_package()
{
  local PKG="$1"
  dpkg -l | grep -qw "$PKG" || sudo apt install "$PKG" -yyq
}
```
