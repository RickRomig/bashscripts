# mount_server

1. **Purpose:** Mount a specific sshfs server on the local network using sshfs.

2. **Arguments:** None.

3. **Notes:**
   
   - Checks to see if the server is accessible on the network.
   
   - The mount point will be created if it does not already exist.

```bash
mount_server() {
  local SVR_IP="18"
  local SHARE="HP-6005"
  ping -c3 "$LOCALNET$SVR_IP" > /dev/null 2>&1 || die "$SHARE at $LOCALNET$IP is not online."
  if [ -d "/mnt/$SHARE/" ]; then
    MOUNTED=$(mount | grep "$SHARE")
    if [ -z "$MOUNTED" ]; then
      sshfs -o follow_symlinks rick@"$LOCALNET$SVR_IP:/home/rick" "/mnt/$SHARE/"
      echo "$SHARE has been mounted."
    else
      echo "$SHARE is already mounted"
    fi
  else
    sudo mkdir -p /mnt/$SHARE/    # Create the mount point.
    sudo chown rick:rick /mnt/$SHARE/
    sshfs -o follow_symlinks rick@"$LOCALNET$SVR_IP:/home/rick" "/mnt/$SHARE/"
    echo "$SHARE has been created and mounted."
  fi
}
```
