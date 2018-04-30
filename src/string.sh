#!/usr/local/bin/bash

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

# global replace
function string_replace() {
	local string=$1
	local search_pattern=$2
	local replace_string=$3
	echo "echo $string | sed "s/$search_pattern/$replace_string/g""
	echo $(echo $string | sed "s/$search_pattern/$replace_string/g")
}

# Does not handle spaces in the source string
function string_reverse() {
	local string=$1
	local reversed=()
	echo "$string"
	local len=$(string_len "$string")

	for (( i = $(( len -1 )); i >= 0; i-- )); do
		reversed+=(${string:$i:1})
	done
	echo $(echo ${reversed[@]} | sed 's/ //g')
}

function string_last_indexof() {
	echo "TODO"
}

function string_char_at() {
	local string=$1
	local index=$2

	if [[ -z "$index" ]]; then
		echo "$string"
		return 1
	elif [[ $index -ge $(string_len "$string") ]]; then
		echo "index out of bounds"
		return 1
	fi

	for (( i = 0; i < $(string_len "$string"); i++ )); do
		if [[ $i -eq $index ]]; then
			echo ${string:$i:1}
			return 0
		fi
	done
}

function string_split() {
	local string=$1
	local fs=$2
	if [[ -z "$fs" ]]; then
		fs=" "
	fi

	local array=($(echo "$string" | awk -v fs="$fs" '{split($0,a,fs); for (i=1; i<=length(a); i++) print a[i]}'))
	echo ${array[@]}
}

function string_substring() {
	local first=$1
	local start_index=$2
	local len=$3
	if [[ -z "$len" ]]; then
		len=$(string_len "$first")
	fi
	echo ${first:start_index:len}
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

string_split "path/to/folder" "/"

string_reverse "hello world"

string_char_at "hello world"
string_char_at "hello world" 0
string_char_at "hello world" 24

string_substring "hello world" $(string_indexof "hello world" "world")

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

# indexof (-1)
first="hello world"
second="llo"
echo $(string_indexof "$first" "$second")

# indexof (-1)
first="hello world"
second="world"
echo $(string_indexof "$first" "$second")

# trim
first="    hello world    "
echo "string len before trim is $(string_len "$first")"
first=$(string_trim "$first")
echo "string len after trim is $(string_len "$first")"


# replace
first=" hello world"
echo "$first"
first=$(string_replace "$first" " $" "world")
echo "$first"

# contains
first="hello world"
second="hello"
if [[ $(string_contains "$first" "$second") ]]; then
	echo \"$first\" contains \"$second\"
else
	echo \"$first\" does not contain \"$second\"
fi

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

