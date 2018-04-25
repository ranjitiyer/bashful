#!/usr/local/bin/bash

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
	local map=$1
	local user_list=($@)
	local result_list=()
	for item in ${user_list[@]}; do
		result_list+=($($map $item))
	done
	echo ${result_list[@]}
}

#
# Reduce the list l to r
#
function list_foldl() {
	local user_fn=$1
	shift
	local user_list=($@)
	local accumulator=0
	for item in ${user_list[@]}; do
		accumulator=$($user_fn $item $accumulator)
	done
	echo $accumulator
}

#
# Reduce the list r to l
#
function list_foldr() {
	local user_fn=$1
	shift
	local user_list=($@)
	local accumulator=0	
	for (( i=${#user_list[@]}-1; i>=0; i-- )); do
		accumulator=$($user_fn ${user_list[i]} $accumulator)
	done	
	echo $accumulator
}

# function list_len() {
# 	declare -n _array=$1
# 	echo ${#_array[@]}
# }

function list_drop_first_n() {
	declare -n list=$1
	declare -i n=$2

	# todo
}

function list_drop_last_n() {
	declare -n list=$1
	declare -i n=$2

	# todo	
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
function list_zip() {
  declare -n _array_one=$1
  declare -n _array_two=$2

  declare -A -g zip_result

  declare -i _array_one_size=${#_array_one[@]}
  declare -i _array_two_size=${#_array_two[@]}

  local min_size=0

  echo "array 1 size " $_array_one_size
  echo "array 2 size " $_array_two_size

  if [[ $_array_one_size > $_array_two_size ]]; then
	list_drop_last_n _array_one $(( $_array_one_size-$_array_two_size ))
	min_size=$_array_two_size
  else 
	list_drop_last_n _array_two $(( $_array_two_size-$_array_one_size ))
	min_size=$_array_one_size
  fi

  echo "min size $min_size"

  for (( i=0;i<$min_size; i++ )); do
  	zip_result[${_array_one[i]}]=${_array_two[i]}
  done

  echo ${!zip_result[@]}
}

array_one=( "name" "age" )
array_two=( "ranjit" "30" "irvine" )
echo "calling zip"
list_zip array_one array_two

#
# test foldl
# list len
#

function sum() {
	local elem=$1
	local accumulator=$2
	echo $(( $accumulator+$elem ))
}
list=(1 2 3 4)
result=$(list_foldl sum ${list[@]})	
echo "result of foldl $result"

#
# test foldr
#
list=(1 2 3 4)
result=$(list_foldr sum ${list[@]})	
echo "result of foldr $result"

#
# test list values, list keys,
# list len
#
list=(1 2 3 4)
function times2() {
	echo $(($1 * 2))
}

result=$(list_map times2 ${list[@]})
echo "${result[@]}"

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
