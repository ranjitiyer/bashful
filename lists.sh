#!/bin/bash

# List functions

#
# Returns true if the predicate
# returns true for at least one element in the lust
# else returns false
#
function list_any() {
	predicate=$1
	shift
	user_list=("$@")
	local result=false
	for item in "${user_list[@]}"; do
		if $($predicate $item); then
			result=true
		fi
	done
	echo $result
}

#
# Returns true if the predicate
# returns true for all elements in the lust
# else returns false
#
function list_all() {
	predicate=$1
	shift
	user_list=("$@")
	local result=true
	for item in "${user_list[@]}"; do
		if ! $($predicate $item); then
			result=false
			break
		fi
	done
	echo $result
}

function list_append() {
	echo $@
}

function list_dropfirst() {
	shift
	echo $@
}

function list_droplast() {
	user_list=($@)
	return_list=()
	for (( i=0; i<${#user_list[@]}-1; i++ ));
	do
		result_list+=(${user_list[i]})
	done
	echo ${result_list[@]}
}

function list_dropwhile() {
	predicate=$1
	shift
	user_list=($@)
	result_list=()
	for item in "${user_list[@]}"; do
		if $($predicate $item); then
			result_list+=($item)
		fi
	done
	echo ${result_list[@]}
}

function list_duplicate() {
	n=$1
	value=$2
	result_list=()
	while (( n-- > 0 )); do
		result_list+=($value)
	done
	echo ${result_list[@]}
}

function list_values() {
	user_list=($@)
	echo ${user_list[@]}
}

function list_keys() {
	user_list=($@)
	echo ${!user_list[@]}
}

function list_len() {
	user_list=($@)
	echo ${#user_list[@]}
}

#
# Returns a transformed list
# by applying the user provided
# map function on every element
# in the list
function list_map() {

}

#
# Reduce the list l to r
#
function foldl() {

}

#
# Reduce the list r to l
#
function foldr() {

}

#
# Zip two lists and turn them
# into an associative array
# since BASH does not support
# tuples 
# first=(Name Age)
# second(Ranjit 30)
# result[Name]=Ranjit
# result[Age]=30
#
function zip() {

}

function min() {

}

function max() {

}

#
# test list values, list keys,
# list len
#
list=(1 2 3 4)
list_values ${list[@]}
list_keys ${list[@]}
list_len ${list[@]}

#
# test list duplicate
#
value="##"
result=$(list_duplicate 5 $value)
echo "list duplicate result ${result[@]}"

#
# test list_dropwhile()
#
first=(1 2 3 1 1 1)
function predicate() {
	if [[ $1 == 1 ]]; then
		echo false
	else
		echo true
	fi	
}
result=$(list_dropwhile predicate "${first[@]}")
echo "list_dropwhile result ${result[@]}"

#
# test list_droplast()
#
first=(1 2 3)
result=$(list_droplast ${first[@]})
echo "list_droplast result ${result[@]}"

#
# test list_dropfirst()
#
first=(1 2 3)
second=$(list_dropfirst ${first[@]})
echo "list dropfirst result ${second[@]}"

#
# test list_append()
#
first=(1 2 3)
second=(4 5 6)
third=$(list_append ${first[@]} ${second[@]})


#
# test list_any()
#
first=(1 2 3)
second=(4 5 6)
third=$(list_append ${first[@]} ${second[@]})
echo "${third[@]}"

#
# test list_any()
#
# use list_anyei
list=(1 2 3)
function predicate() {
	if [[ $1 == 1 ]]; then
		echo true
	else
		echo false
	fi	
}

result=$(list_any predicate "${list[@]}")
if $result; then
	echo "predictate is true for some element in the list"
else	
	echo "predicate test failed"
fi


#
# test list_all()
#
list=(1 1 1)
result=$(list_all predicate "${list[@]}")
if $result; then
	echo "predictate is true for some element in the list"
else	
	echo "predicate test failed"
fi
