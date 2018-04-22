#!/bin/bash

# A thin wrapper around curl

declare -F _map
declare -F _filter

# list, map returns a list
function map() {
	local list=$1
	echo "inside map input list size is ${#list[@]}"
	local mapped_list=()
	for item in ${list[@]}; do
		result=$(_map $item)
		mapped_list+=($result)
		echo "$result"
	done

	# 'return' mapped list
	echo ${mapped_list[@]}
}

## user defined
function _map() {
	echo "_map is invoked with $1"
}

function copyFiles() {
   func=$1
   echo "function name is $func"
   shift
   arr=("$@")
   for i in "${arr[@]}";
      do
          echo "$i"
          $func $i
      done
}

array=("one" "two" "three")

copyFiles _map "${array[@]}"

list1=(1 2 3)
echo "List 1 has ${#list1[@]} elements"
map ${list1[@]} _map


# # user defined
# function _map() {
# 	echo "_map2 is invoked with $1"
# }

# list2=(mon tue wed)
# echo "List 2 has ${#list2[@]} elements"
# map $list2 _map

headers=()
params=()

function request_add_headers() {
	echo ""
}

function request_add_params() {
	echo ""
}

function request_add_user_agent() {
	echo ""
}

function request_add_referrer() {
	echo ""
}

function request_get() {
	echo ""
}

function request() {
	echo ""
}

function request_post() {
	echo ""
}

function request_put() {
	echo ""
}

function request_patch() {
	echo ""
}

function request_delete() {
	echo ""
}

function request_get_response_headers() {
	echo ""
}

function request_get_response_header() {
	echo ""
}

function request_get_response_line() {
	echo ""
}

function request_get_response_http_code() {
	echo ""
}

function request_get_response_content_type() {
	echo ""
}
