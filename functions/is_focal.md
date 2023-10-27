# is_focal

1. **Purpose:** Returns true if the distribution is based on Ubuntu 20.04 (Focal Fossa), i.e., Linux Mint 20.

2. **Arguments:** None

3. **Returns:** True or False

4. Speciically tests for distributions based on Ubuntu 20.04 because of changes to the distribution such as Chromium as a Snap package and change to Python support.

```bash
is_focal() {
  UBUNTU_CODE=$(grep 'UBUNTU_CODENAME' /etc/os-release | cut -d '=' -f2)
  [ "$UBUNTU_CODE" = "focal" ] && return $TRUE || return $FALSE
}
```
