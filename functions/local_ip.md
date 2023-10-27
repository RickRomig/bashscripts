# local_ip

1. **Purpose**: Extracts the last octet of the local IP address and assigns to a variable.

2. Assumes a Class C /24 network, last octet between 1 and 254.

3. By default, extracts the last octet for the Ethernet interface, if it's active. Otherwise, extracts the last octet for the wireless interface, if active.
   
   ```bash
   local_ip() {
     en_ip=$(ip route show | awk '/en/ && /src/ {print $9}')
     wl_ip=$(ip route show | awk '/wl/ && /src/ {print $9}')
     et_ip=$(ip route show | awk '/eth/ && /src/ {print $9}')
   
     if [[ -n "$en_ip" ]]; then
       octet="${en_ip##*.}"
     elif [[ -n "$et_ip" ]]; then
       octet="${et_ip##*.}"
     elif [[ -n "$wl_ip" ]]; then
       octet="${wl_ip##*.}"
     else
       die "No IP address. Check network status." 1
     fi
     printf "%s" "$octet"
   }
   ```

### Usage:

```bas
localnet="192.168.0"
localip="$(local_ip)"
echo "Local IP address is $localnet.$localip"
# Alternatively:
echo "Local IP address: $localnet.$(local_ip)"
```
