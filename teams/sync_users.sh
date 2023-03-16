#!/bin/bash

#set -xe

auth_header="Authorization: Bearer ${GITHUB_TOKEN}"
content_header="Accept: application/vnd.github.v3+json"
org="abhi-organization"
base_url="https://api.github.com/orgs/${org}/teams"


# curl -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/orgs/${org}/teams"
#src_dir="/Users/aj5731/Desktop/Personal_Repo/new"


if [[ -d ${src_dir}/teams ]]; then
	IFS=$'\n'
  for f in $(find ${src_dir}/teams/*.csv -type f); do
    group_name=$(basename ${f} | awk '{split($0,a,"."); print a[1]}')
    echo "Processing group: ${group_name}"
    team_url="${base_url}/${group_name}/members"
	  current_members=$(curl -X GET -H "${auth_header}" -H "${content_header}" "${team_url}" | jq -r .[].login)
    if [[ $? != 0 ]]; then
      echo "Failed to get current members - ${current_members}"
      exit 1
    fi
    current_members_array=($current_members)

      new_members=()
	  for user_data in $(cat ${f} |grep -iv 'username'); do
      user_name=$(echo $user_data | awk '{split($0,a,","); print a[1]}')
      if ! echo "${current_members}" | grep -q "${user_name}"; then
        new_members+=("${user_name}")
        fi
	    current_members_array=("${current_members_array[@]/$user_name}")
	  done

      if [[ ${#new_members[@]} -gt 0 ]]; then
        echo "New members available to add : ${new_members[*]}"
        for new_member in ${new_members[@]}; do
            echo "Adding new member ${new_member} to ${group_name}"
            url="${base_url}/${group_name}/memberships/${new_member}"
            update=$(curl -s -w "::%{http_code}" -X PUT -H "${auth_header}" -H "${content_header}" "${url}" -d '{"role": "member"}')
            echo "${update}" | grep '::200'
            if [[ $? != 0 ]] ; then
              echo "Failed to update - ${update}"
              exit 1
            fi
        done
      else
        echo "No new member found to be added to group: ${group_name}"
      fi

      if [[ -n "${current_members_array[@]}" ]]; then
        echo "Remaining users - ${current_members_array[*]}"
        for remaining_user in ${current_members_array[@]}; do
            echo "Removing ${remaining_user} from ${group_name}"
            url="${base_url}/${group_name}/memberships/${remaining_user}"
            echo "url: ${url}"
            remove=$(curl -s -w "::%{http_code}" -X DELETE -H "${auth_header}" -H "${content_header}" "${url}")
            echo "${remove}" | grep '::204'
            if [[ $? != 0 ]] ; then
              exit 1
              echo "Failed to remove - ${remove}"
            fi
        done
       else
         echo "No member found to be removed from group: ${group_name}"
       fi
       echo
       echo
   done
fi