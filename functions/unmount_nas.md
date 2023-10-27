# unmount_nas

1. **Purpose:** Unmount the SSHFS share on the NAS created/mounted by `mount_server`.
2. **Arguments:** None
3. **Notes:**
   - Also removes `$tmp_dir` or `$tmp_file` if they exist.
   - Function should be called by the `trap` command to run whenever the calling script exits for whatever reason.

```bash
unmount_nas() {
  local share="NASD97167"
  mounted=$(mount | grep "$share")
  [[ -n "$mounted" ]] && fusermount -u "/mnt/$share"
  [[ -d "$tmp_dir" ]] && rm -rf "$tmp_dir"
  [[ -f "$tmp_file" ]] && rm -f "$tmp_file"
}
```
