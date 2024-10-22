# is_url_good

1. **Purpose**: Check if a URL is valid and accessible.

2. **Arguments**: A URL address, such as https://googl.com

3. **Returns**: TRUE (0) is the URL is accessible, otherwise returns FALSE (0).

### Code
```bash
is_url_good() {
  local url="$1"
  wget --spider -q "$url" && return "$TRUE" || return "$FALSE"
}
```
