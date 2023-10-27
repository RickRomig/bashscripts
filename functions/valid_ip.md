# valid_ip

* Takes as input the last octet of an IP address on the local network.
* Assumes a Class C /24 network, last octet between 1 and 254.
* Returns 0 if the argument is a valid and reachable IP address.
* Exits with exit code of 1 if the argument is empty string.
* Exits with exit code of 2 if the address is local IP address.
* Exits with exit code of 3 if the address is valid but unreachable.
* Exits with exit code of 4 if the argument is outside the range of valid IP addresses.
* Exits with exit code of 5 if the argument is not an integer value.

```bash
declare -r localnet="192.168.0"

valid_ip() {
  local octet="$1"
  local status=0
  localip="$(local_ip)"
  if [[ -z "$octet" ]]; then
    status=1    # No argument passed.
  elif [[ "$1" =~ ^[0-9]+$ ]] 2>/dev/null; then
    # Argument is an integer value
    if (( octet > 0 )) && (( octet < 255 )); then
      # Valid address - test if reachable or local machine
      if (( localip = octet )); then
        status=2    # Valid address - local machine
      elif ping -c 1 "$localnet.$octet" > /dev/null 2>&1; then
        status=0    # Valid and reachable address
      else
        status=3    # Valid address but unreachable
      fi
    else
      status=4  # invalid address - out of range
    fi
  else
    status=5    # Argument is a non-integer value
  fi

  # Display the status message
  case $status in
    0 )
      printf "%s.%s is a valid and reachable IP address.\n" "$localnet" "$octet" ;;
    1 )
      printf "\e[91mERROR:\e[0m No argument passed. No host IP.\n" >&2
      printf "Enter the last octet of the target IP address (1 - 254).\n" >&2 ;;
    2 )
      printf "\e[91mERROR:\e[0m %s.%s is the local client computer.\n" "$localnet" "$octet" >&2 ;;
    3 )
      printf "\e[91mERROR:\e[0m $%s.%s is valid IP address but is unreachable.\n" "$localnet" "$octet" >&2
      printf "Check to see if it is on the network.\n" >&2 ;;
    4 )
      printf "\e[91mERROR:\e[0m %s.%s is not a valid IP address.\n" "$localnet" "$octet" >&2
      printf "Must be between an integer between 1 and 254.\n" >&2 ;;
    * )
      printf "\e[91mERROR:\e[0m Invalid argument.\n" >&2
      printf "Must be between an integer between 1 and 254.\n" >&2 ;;
  esac

  (( status == 0 )) && return "$status" || exit "$status"
}
```

### Usage:

```bash
# Local /24 network (first 3 octets)
readonly localnet="192.168.0"

valid_ip "$1"
hostip="$?"

echo "Host IP = $hostip"
echo "IP address = $localnet.$hostip"
ssh $localnet.$hostip
```
