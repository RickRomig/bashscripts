# Mount/Unmount Server

### Mount the HP-6005 server
```bash
mount_server() {
  IP="18"
  SHARE="HP-6005"
  ping -c3 "$LOCALNET$IP" > /dev/null 2>&1 || die "$SHARE at $LOCALNET$IP is not online."
  if [ -d "/mnt/$SHARE/" ]; then
    MOUNTED=$(ls "/mnt/$SHARE/")
    if [ -z "$MOUNTED"]; then
      sshfs -o follow_symlinks rick@"$LOCALNET$IP:/home/rick" "/mnt/$SHARE/"
      echo "$SHARE has been mounted."
    else
      echo "$SHARE is already mounted"
    fi
  else
    sudo mkdir -p /mnt/$SHARE/
    sudo chown rick:rick /mnt/$SHARE/
    sshfs -o follow_symlinks rick@"$LOCALNET$IP:/home/rick" "/mnt/$SHARE/"
    echo "$SHARE has been created and mounted."
  fi
}
```

### Unmount the HP-6005 server
```bash
unmount_server() {
  fusermount -u /mntHP-6005/
}
```

### Add at the beginning of the Execution portion of the script:
```bash
# Mount the package server
mount_server

# Unmount the package server on exit
trap unmount_server EXIT
```
