# in_repos

1. **Purose:** Returns true if a package is found in the distribution's repositories
   and returns false if the package is not found. This includes PPAs and other added softtware sources.

2. **Argument**:
   
   - \$1 - package to be checked
   
   ```bash
   function in_repos()
   {
     local PKG="$1"
     IN_REPOS=$(apt-cache show "$PKG" 2>/dev/null)
     [ -n "$IN_REPOS" ] && return "$TRUE" || else return "$FALSE"
   }
   ```


