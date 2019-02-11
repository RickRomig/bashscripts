# Changelog for bashscripts

#### 8 February 2019
**clean-bin**

Replaced the following code to remove *~ backup files

```
	ls *~ > /dev/null 2>&1
	if [ "$?" = "0" ]
	then
		rm -v *~
	fi
````
with the following

```
	find ./ -maxdepth 1 -type f -iname "*~" -print -exec rm {} \;
````

#### 6 February 2018

**getinfo/sysinfo**

Improved the appearance of the displayed output and changed some methods of gathering system data. Renamed to sysinfo as a more descriptive file name.

#### 5 February 2018

**dos2linux**

Fixed variable name inside the if statement that checks to see if target file exists.

```
	if [ ! -f "$myfile" ]; then
		echo "Error: $myscript not found."
		usage
	fi
```

Changed to read

```
	if [ ! -f "$myfile" ]; then
		echo "Error: $myfile not found."
		usage
	fi
```
#### 10 February 2010

**chkupdates**

Changed variable names to lower case and enclosed variables in quotes that are in test brackets.

**upper2lowere**

Changed variable names to lowwer case.
