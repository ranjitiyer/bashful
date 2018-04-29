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


function string_last_indexof() {
	echo ""
}

function string_split() {
	echo ""
}

function string_substring() {
	echo ""
}

function string_reverse() {
	echo ""
}

# Improvment would be to 
# drop prefix and check len of first
function string_starts_with() {
	local string=$1
	local substring=$2
	if [[ "$string" =~ ^"$substring" ]]; then
		return 0
	else	
		return 1
	fi
}

function string_ends_with() {
	local string=$1
	local substring=$2
	if [[ $string =~ $substring$ ]]; then
		return 0
	else	
		return 1
	fi
}

# first="hello world"
# second="llo w"
function string_contains() {
	echo "string contains called"
	local first=$1
	local second=$2

	local first_len=$(string_len "$first")
	for (( i = 0; i < $first_len; i++ )); do
		first=${first:$i}
		first_len=$(string_len "$first")

		# drop prefix
		local first_prefix=${first#$second}

		# if dropping modifies the len of first
		# then we have a match
		local first_len_new=$(string_len "$first_prefix")
		if [[ $first_len -gt $first_len_new ]]; then
			return 0
		fi
	done
	return 1
}

# global replace
function string_replace() {
	local string=$1
	local search_pattern=$2
	local replace_string=$3
	echo "echo $string | sed "s/$search_pattern/$replace_string/g""
	echo $(echo $string | sed "s/$search_pattern/$replace_string/g")
}


function string_trim {
	local string=$1
	string=$(echo $string | sed 's/{ *$;^ *}//')
	echo "$string"
}

function string_indexof() {
	local first=$1
	local second=$2
	local orig_len=$(string_len "$first")
	for (( i = 0; i < $orig_len; i++ )); do
		local temp=${first:$i}
		if $(string_starts_with "$temp" "$second"); then
			echo $i
			return 0
		fi
	done

	echo -1
	return 1
}


############### Testing ###############

# startswith
string_starts_with "hello world" "hello"
echo $?
string_starts_with "hello world" "world"
echo $?
string_starts_with "lo world" "world"
echo $?

string_ends_with "hello world" "world"
echo $?
string_ends_with "hello world" "hello"
echo $?

echo $(string_indexof "hello world" "world")
echo $(string_indexof "hello world" "hide")

# # indexof (-1)
# first="hello world"
# second="llo"
# echo $(string_indexof "$first" "$second")

# # indexof (-1)
# first="hello world"
# second="world"
# echo $(string_indexof "$first" "$second")

# # trim
# first="    hello world    "
# echo "string len before trim is $(string_len "$first")"
# first=$(string_trim "$first")
# echo "string len after trim is $(string_len "$first")"


# # replace
# first=" hello world"
# echo "$first"
# first=$(string_replace "$first" " $" "world")
# echo "$first"

# # contains
# first="hello world"
# second="hello"
# if [[ $(string_contains "$first" "$second") ]]; then
# 	echo \"$first\" contains \"$second\"
# else
# 	echo \"$first\" does not contain \"$second\"
# fi

# if $(string_contains "$first" "$second") ; then
# 	echo "yes"
# else	
# 	echo "no"
# fi


# # startswith
# first="hello world"
# second="hello"
# if $(string_starts_with "$first" "$second") ; then
# 	echo "yes"
# else	
# 	echo "no"
# fi

# # startswith
# first="hello world"
# second="world"
# if [[ $(string_ends_with "$first" "$second") ]]; then
# 	echo "yes"
# else
# 	echo "no"
# fi

