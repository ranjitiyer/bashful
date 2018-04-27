#!/usr/local/bin/bash

source ../src/lists.sh

# Test list_zip
array_one=( "name" "age" )
array_two=( "ranjit" "30" "irvine" )
echo "calling zip"
list_zip array_one array_two

# Test list_len
function get_len() {
	local list=(1 2 3 4 5 6 7 8)
	len=$(list_len list)
	echo "list length is $len"	
}
get_len

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