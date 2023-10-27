# clone_repo

1. **Purpose:** Clones a repository from the local Gitea server to the \~/Downloads directory.

2. **Arguments:**
   
   - \$1 - The basename of the reposiitory to be cloned.

3. **Notes:**
   
   - The URL of the Gitea server is hard-coded into the function.
   
   - The .git extension is automatic appended to the repository name.

```bash
clone_repo() {
  local git_svr="http://192.168.0.16:3000/Nullifidian"
  local git_repo="${1}.git"
  git clone  "$git_svr/$git_repo" "$HOME/Downloads"
}
```
