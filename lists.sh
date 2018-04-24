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


#
# test list_droplast()
#
echo "hi"
first=(1 2 3)
# doesn't work when called inside $()
list_droplast ${first[@]}

# #
# # test list_dropfirst()
# #
# first=(1 2 3)
# second=$(list_dropfirst ${first[@]})

# #
# # test list_append()
# #
# first=(1 2 3)
# second=(4 5 6)
# third=$(list_append ${first[@]} ${second[@]})


# #
# # test list_any()
# #
# first=(1 2 3)
# second=(4 5 6)
# third=$(list_append ${first[@]} ${second[@]})
# echo "${third[@]}"


# #
# # test list_any()
# #

# # use list_any
# list=(1 2 3)
# function predicate() {
# 	if [[ $1 == 1 ]]; then
# 		echo true
# 	else
# 		echo false
# 	fi	
# }

# result=$(list_any predicate "${list[@]}")
# if $result; then
# 	echo "predictate is true for some element in the list"
# else	
# 	echo "predicate test failed"
# fi


# #
# # test list_all()
# #
# list=(1 1 1)
# result=$(list_all predicate "${list[@]}")
# if $result; then
# 	echo "predictate is true for some element in the list"
# else	
# 	echo "predicate test failed"
# fi
