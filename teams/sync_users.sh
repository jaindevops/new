#!/bin/bash

set -xe

auth_header="Authorization: Bearer ${GITHUB_TOKEN}"
content_header="Accept: application/vnd.github.v3+json"
org="abhi-organization"
base_url="https://api.github.com/orgs/${org}/teams"

# if [[ -d ${src_dir}/teams ]]; then
# 	IFS=$'\n'
#   for f in $(find ${src_dir}/teams/*.csv -type f); do
#     group_name=$(basename ${f} | awk '{split($0,a,"."); print a[1]}')
#     echo "Processing group ${group_name}"
#     team_url="${base_url}/${group_name}/members"
# 	  current_members=$(curl -X GET -H "${auth_header}" -H "${content_header}" "${team_url}" | jq -r .[].login)
#     if [[ $? != 0 ]]; then
#       echo "Failed to get current members - ${current_members}"
#       exit 1
#     fi
#     current_members_array=($current_members)

# 	  for user_data in $(cat ${f} |grep -iv 'username'); do
#       user_name=$(echo $user_data | awk '{split($0,a,","); print a[1]}')
#       echo "Adding ${user_name} to ${group_name}"
# 	  	url="${base_url}/${group_name}/memberships/${user_name}"
# 	  	update=$(curl -s -w "::%{http_code}" -X PUT -H "${auth_header}" -H "${content_header}" "${url}" -d '{"role": "member"}')
# 	  	echo "${update}" | grep '::200'
# 	  	if [[ $? != 0 ]] ; then
# 	      echo "Failed to update - ${update}"
# 	      exit 1
# 	  	fi
# 	    current_members_array=("${current_members_array[@]/$user_name}")
# 	  done

#     echo "Remaining users - ${current_members_array[*]}"

# 	  for remaining_user in "${current_members_array[@]}"; do
# 	    if [[ -n "${remaining_user}" ]]; then
#         echo "Removing ${remaining_user} from ${group_name}"
#         url="${base_url}/${group_name}/memberships/${remaining_user}"
#         echo "url: ${url}"
#   	    remove=$(curl -s -w "::%{http_code}" -X DELETE -H "${auth_header}" -H "${content_header}" "${url}")
#   	    echo "${remove}" | grep '::204'
#   	  	if [[ $? != 0 ]] ; then
#   	      exit 1
#   	      echo "Failed to remove - ${remove}"
#   	  	fi
#       fi
# 	  done
# 	done
# fi