# progressbar function

```
progressbar()
{
  bar="=================================================="
  barlength=${#bar}
  i=0
  while ((i < 100)); do
    n=$((i*barlength / 100)) # Number of bar segments to draw     $((i/2))
    printf "\r[%-${barlength}s]" "${bar:0:n}"
    ((i += RANDOM%5+2))            # i = percentage done
    sleep 1
  done
  echo
}
```
