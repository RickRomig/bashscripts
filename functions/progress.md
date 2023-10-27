# progress.sh

```
#!/bin/bash
# progress.sh

while true; do echo -n .; sleep 1; done &
trap 'kill $!' SIGTERM SIGKILL

echo "Running tar command: "
tar -cf test.tar ./*
echo done

kill $!
```

**Notes**

1. Place the while loop and the trap builtin before the code you want to show progress for. The loop will runit in the background.
2. Kill the background process after the task is finished.
3. The sleep command determines the interview of the dots.
