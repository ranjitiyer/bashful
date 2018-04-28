#!/usr/local/bin/bash

# Expansion

# STR="/path/to/foo.cpp"
# echo ${STR%.cpp}    # /path/to/foo
# echo ${STR%.cpp}.o  # /path/to/foo.o

# echo ${STR##*.}     # cpp (extension)
# echo ${STR##*/}     # foo.cpp (basepath)

# echo ${STR#*/}      # path/to/foo.cpp
# echo ${STR##*/}     # foo.cpp

# echo ${STR/foo/bar} # /path/to/bar.cpp
# STR="Hello world"
# echo ${STR:6:5}   # "world"
# echo ${STR:-5:5}  # "world"
# SRC="/path/to/foo.cpp"
# BASE=${STR##*/}   #=> "foo.cpp" (basepath)
# DIR=${SRC%$BASE}  #=> "/path/to" (dirpath)

# Slicing

# name="John"
# echo ${name}
# echo ${name/J/j}    #=> "john" (substitution)
# echo ${name:0:2}    #=> "jo" (slicing)
# echo ${name::2}     #=> "jo" (slicing)
# echo ${name::-1}    #=> "joh" (slicing)
# echo ${food:-Cake}  #=> $food or "Cake"


# Substitution

# ${FOO%suffix}	Remove suffix
# ${FOO#prefix}	Remove prefix
# ${FOO%%suffix}	Remove long suffix
# ${FOO##prefix}	Remove long prefix
# ${FOO/from/to}	Replace first match
# ${FOO//from/to}	Replace all
# ${FOO/%from/to}	Replace suffix
# ${FOO/#from/to}	Replace prefix

# ${FOO:0:3}

function string_len(){
	local str=$1
	echo ${#str}
}

function string_to_upper() {
	local _upper=$(echo "$1" | tr '[:lower:]' '[:upper:]')
	echo $_upper
}

function string_to_lower() {
	local _upper=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	echo $_upper
}

function string_indexof() {

	echo ""
}

function string_last_indexof() {
	echo ""
}

function string_split() {
	echo ""
}

function string_substring() {
	echo ""
}

function string_trim() {
	echo ""
}

function string_replace() {
	echo ""
}

function string_reverse() {
	echo ""
}

function string_starts_with() {
	local string=$1
	local substring=$2

	local str_len=$(string_len $string)
	local sstr_len=$(string_len $substring) 

	if [[ $str_len -lt $sstr_len ]]; then
		return 1
	fi

	# truncate first and compare with second
	string=${string:0:$str_len}
	if [[ $string == $substring ]]; then
		return 0
	else
		return 1
	fi
}



function string_ends_with() {
	local string=$1
	local substring=$2

	local orig_first_len=$(string_len "$string")
	local orig_second_len=$(string_len "$substring")

	if [[ $orig_second_len -gt $orig_first_len ]]; then
		echo "substring is longer than the source string"
		return 1
	fi

	# drop the suffix
	string=${string%$substring}

	# get the new len of first
	local new_first_len=$(string_len "$string")

	# if new len of first is what's left after 
	# dropping substring then we have a match
	if [[ $new_first_len -eq $(( $orig_first_len - $orig_second_len  )) ]]; then
		echo "$1 ends with $2"
		return 0
	else
		return 1
	fi
}

function string_contains() {
	echo ""
}


############### Testing ###############

# startswith
first="hello world"
second="hello"
if $(string_starts_with "$first" "$second") ; then
	echo "yes"
else	
	echo "no"
fi

# startswith
first="hello world"
second="world"
if [[ $(string_ends_with "$first" "$second") ]]; then
	echo "yes"
else
	echo "no"
fi

