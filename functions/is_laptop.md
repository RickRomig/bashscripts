# is_laptop

1. **Purpose**: Check if the system is a laptop.

2. None

3. **Returns**: TRUE (0) is the system is a laptop, otherwise returns FALSE (0).

### Code
```bash
is_laptop() {
  [[ -d /proc/acpi/button/lid/ ]] && return "$TRUE" || return "$FALSE"
}
```
