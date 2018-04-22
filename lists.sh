#!/bin/bash

# List functions

#
# Tests if a predicate is true
# for any element in the list
# Example: 
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
# Tests if a predicate is true
# for all elements in the list
#
function list_all() {

}

#
# TESTS
#

# use list_any
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

