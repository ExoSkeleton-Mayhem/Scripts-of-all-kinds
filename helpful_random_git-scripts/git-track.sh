#!bin/bash

git config --global alias.track '!sh -c "
if [ \$# -eq 2 ]
 then
   echo \"Setting tracking for branch \" \$1 \" -> \" \$2;
   git branch --set-upstream \$1 \$2;
 else
   git for-each-ref --format=\"local: %(refname:short) <--sync--> remote: %(upstream:short)\" refs/heads && echo --URLs && git remote -v;
fi  
" -'
