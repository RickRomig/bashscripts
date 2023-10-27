#Alias functions
##~/.bash_aliases

1. Software installation
  ```bash
  install() {
    sudo apt update
    sudo apt install $*
    [[ "$?" -eq 0 ]] && echo "Success" || echo "Operation failed"
  }
  ```
2. Check if a program is installed
  ```bash
  exists() {
    command -v "$1" > /dev/null && echo "$1 installed" || echo "$1 not installed"
  }
  ```
3. Get a future date a given number of days from the current date
  ```bash
  future() {
    echo "$1 days from now will be $(date -d "$(date +%y-%m-%d) + $1 days" +"%d %b %Y")"
  }
  ```
4. Kill jobs
  ```bash
  killjobs() {
    kill -9 $(jobs -ps)
  }
  ```
5. Remove files ending with a tilde in the current directory
  ```bash
  rm~() {
    find ./ -maxdepth 1 -type f -regex '\./.*~$' -print -exec rm {} \;
  }
  ```
6. Change directories and list its contents in one command
  ```bash
  cdls() {
    local dir="$1"
    local dir="${dir:=$HOME}"
    if [[ -d "$dir" ]]; then
      cd "$dir" >/dev/null; ls --color=auto
    else
      echo "bash: cdls: $dir: Directory not found"
    fi
  }
  ```
7. Copy a file to another directory and change to that directory in one command
  ```bash
  cpcd (){
    if [ -d "$2" ];then
      cp $1 $2 && cd $2
    else
      cp $1 $2
    fi
  }
  ```
8. Move a file to another directory and change to that directory in one command
  ```bash
  mvcd (){
    if [ -d "$2" ];then
      mv $1 $2 && cd $2
    else
      mv $1 $2
    fi
  }
  ```
9. Create a directory and cd into it
  ```bash
  mkcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
  }
  ```
10. Extract compressed files using various compression utilitiesl.
  ```bash
  ex () {
    if [ -f $1 ]; then
      case $1 in
        *.tar.bz )    tar xjf $1  ;;
        *.tar.gz )    tar xzf $1  ;;
        *.bz2 )       bunzip2 $1  ;;
        *.rar )       unrar  $1   ;;
        *.gz )        gunzip $1   ;;
        *.tar )       tar xf $1   ;;
        *.tbz2 )      tar xjf $1  ;;
        *.tgz )       tar xzf $1  ;;
        *.zip )       unzip $1    ;;
        *.Z )         uncompress $1 ;;
        *.7z )        7z x $1     ;;
        *.deb )       ar x $1     ;;
        *.tar.xz )    tar xf $1   ;;
        *.tar.zst )   unzstd $1   ;;
        * )           echo "'$1' cannot be extracted via ex()" ;;
      esac
    else
      echo "'$1' is not a valid file."
    fi
  }
  ```
11. Change directories upwards X number of directories.
  ```bash
  cdup() {
	  local d=""
	  local limit="$1"
	  # Default to limit of 1
	  if [[ -z "$limit" || "$limit" -le 0 ]]; then limit=1; fi

	  for (( i=1;i<=limit;i++ )); do d="../$d"; done

	  # Perform cd. Show error if cd fails.
	  if ! cd "$d"; then echo "Couldn't go up $limit directories."; fi
    # Won't go past root (/) no matter how many levels are passed to the function.
  }
  ```
