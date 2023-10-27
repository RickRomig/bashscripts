# Init checks

1. Systemd
   
   ```bash
   is_systemd()
   {
       [ -d /run/systemd/system ] && return "$TRUE" || return "$FALSE"
   }
   ```

2. SysV
   
   ```bash
   is_sysv()
   {
       SYSV=$(init --version 2>/dev/null | awk '{print $1}')
       [ "$SYSV" = "SysV" ] && return "$TRUE" || return "$FALSE"
   }
   ```

3. Other checks:
   
   ```bash
   strings /sbin/init | grep -q "/lib/systemd" && echo SYSTEMD
   strings /sbin/init | grep -q "sysvinit" && echo SYSVINIT
   strings /sbin/init | grep -q "upstart" && echo UPSTART
   
   
   ```

4. more
