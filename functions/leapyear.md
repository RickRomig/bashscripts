# leapyear

1. **Purpose**: Return true (0 )if the current year is a leap year, otherwhise false (1).

2. **Argument**:

   - \$1 - 4-digit year to be checked

   ```bash
   leapyear()
   {
     YEAR=$(date +"%Y")

     if [ $(( year % 4 )) -ne 0 ] ; then
       return "$FALSE"
     elif [ $(( year % 400 )) -eq 0 ] ; then
       return "$TRUE"
     elif [ $(( year % 100 )) -eq 0 ] ; then
       return "$FALSE"
     else
       return "$TRUE"
     fi
   }
   ```

#### Alternative without if statements

```bash
leapyear()
{
  YEAR=$(date +"%Y")
  [ $(( YEAR % 4 )) -ne 0 ] && return "$FALSE"
  [ $(( YEAR % 400 )) -eq 0 ] && return "$TRUE"
  [ $(( YEAR % 100 )) -eq 0 ] && return "$FALSE" || return "$TRUE"
}
```

### Usage

```
declare -r TRUE=0
declare -r FALSE=1

leapyear
LEAP="$?"

if [ "$LEAP" = "$TRUE" ]; then
  echo "February has 29 days."
else
  echo "February has 28 days."
fi
```
