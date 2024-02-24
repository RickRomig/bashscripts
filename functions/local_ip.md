# local_ip

1. **Purpose**: Extracts the last octet of the local IP address and assigns to a variable.

2. Assumes a Class C /24 network, last octet between 1 and 254.

### Code:

```bash
local_ip() {
  octet=$(ip route get 1.2.3.4 | awk '{print $7}' | cut -d'.' -f4)
  [[ -z "$octet" ]] && die "No IP address found. Check network status." 1
  printf "%s" "$octet"
}
```

### Usage:

```bash
localnet="192.168.0"  # Example only, localnet is declared as a global variable in functionlib
localip="$(local_ip)"
echo "Local IP address is $localnet.$localip"
# Alternatively:
echo "Local IP address: $localnet.$(local_ip)"
```
