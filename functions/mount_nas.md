# mount_nas

1. **Purpose:** Mount the Network Area Storage server on the local network using sshfs.

2. **Arguments:** None

3. **Notes:**
   
   - Checks to see if the server is accessible on the network.
   
   - The mount point will be created if it does not already exist.

```bash
mount_nas() {
  local server_ip="4"
  local share="NASD97167"
  ping -c3 "$localnet.$server_ip" > /dev/null 2>&1 || die "$share at $localnet.$server_ip is not online."
  if [[ -d "/mnt/$share/" ]]; then
    mounted=$(mount | grep "$share")
    if [[ -z "$mounted" ]]; then
      sshfs -o follow_symlinks rick@"$localnet.$server_ip:" "/mnt/$share/"
      echo "$share has been mounted."
    else
      echo "$share is already mounted"
    fi
  else
    sudo mkdir -p "/mnt/$share/"    # Create the mount point.
    sudo chown rick:rick "/mnt/$share/"
    sshfs -o follow_symlinks rick@"$localnet.$server_ip:" "/mnt/$share/"
    echo "$share has been created and mounted."
  fi
} 
```
