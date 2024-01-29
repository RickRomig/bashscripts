#Alias functions
##~/.bash_aliases

1. Check if a program is installed
  ```bash
  exist() {
    command -v "$1" > /dev/null && echo "$1 installed" || echo "$1 not installed"
  }
  exist <program>
  ```
2. Get a future date a given number of days from the current date
  ```bash
  future() {
    echo "$1 days from now will be $(date -d "$(date +%y-%m-%d) + $1 days" +"%d %b %Y")"
  }
  future 90
  ```
3. Kill stopped jobs
  ```bash
  killjobs() {
    kill -9 $(jobs -ps)
  }
  killjobs
  ```
4. Remove files ending with a tilde in the current directory
  ```bash
  rm~() {
    find ./ -maxdepth 1 -type f -regex '\./.*~$' -print -exec rm {} \;
  }
  rm~
  ```
5. Change directories and list its contents in one command
  ```bash
  cdls() {
  local dir="${1:-$HOME}"
  if [[ -d "$dir" ]]; then
     cd "$dir" >/dev/null; ls -CF --group-directories-first --color=auto
  else
     echo "bash: cdls: $dir: Directory not found"
  fi
  }
  cdls .config
  ```
6. Copy a file to another directory and change to that directory in one command
  ```bash
  cpcd (){
    if [ -d "$2" ]; then
      cp $1 $2 && cd $2
    else
      cp $1 $2
    fi
  }
  cpcd foo /bar
  ```
7. Move a file to another directory and change to that directory in one command
  ```bash
  mvcd (){
    if [ -d "$2" ]; then
      mv $1 $2 && cd $2
    else
      mv $1 $2
    fi
  }
  mvcd foo /bar
  ```
8. Create a directory and cd into it
  ```bash
  mkcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
  }
  mkcd foobar
  ```
9. Copy a text file to multiple systems using DSH
  ```bash
  dcp() {
	  cat "$1" | dsh -g "$2" -i -c "tee $3/$(basename "$1")"
  }
  dcp foo group path/on/remote/systems
  ```
10. Decrypt an encrytped pdf file
  ```bash
  decryptpdf() {
	  qpdf --password="$1" --decrypt "$2".pdf --replace-input
  }
  decryptpdf 3287 foobar.pdf
  ```
11. Add a file to be staged in git and create a commit for it
  ```bash
  gcommit() {
	  git status
	  git add $1
	  git commit -m "$1 - $2"
  }
  gcommit foo.bar "Made some changes to foo.bar"
  ```
12. Add all new or modified files to be staged in git and create a commit
  ```bash
  gcommitall() {
	  git status
	  git add -A
	  git commit -m "$1"
  }
  gcommitall "Changed some files."
  ```
13. Extract compressed files using various compression utilitiesl.
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
  gcommitall foobar.tar.gz
  ```
14. Parse git branch, identifies git branch in bash prompt (~/.bashrc)
  ```bash
  parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
  }
```
15. Alias for ssh if terminal is kitty
  ```bash
  [[ "$TERM" = "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"
  ```