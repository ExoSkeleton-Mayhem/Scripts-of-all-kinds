#!/bin/bash
TOKEN="r25rRi283LzeqkseHTPH"; PREFIX="ssh_url_to_repo"; curl --header "PRIVATE-TOKEN: $TOKEN" http://gitlab.com/api/v4/projects?per_page=100 | grep -o "\"$PREFIX\":[^ ,]\+" | awk -F ':' '{printf "ssh://"; for (i=2; i<NF; i++) printf $i "/"; print $NF}' | xargs -L1 git clone


curl --header "Authorization: Bearer r25rRi283LzeqkseHTPH " https://gitlab.example.com/api/v4/projects

