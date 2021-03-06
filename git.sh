#!/bin/bash
DONE=./git/done.txt
TODO=./git/todo.txt
ERROR=./git/error.txt

function loadGit() {
    echo -e "\[33m LOADED REPOSITORIES: (+ YES / - NOT) from File: $TODO"
    for GIT in $(cat $TODO)
    do
        GIT_CLEANED=${GIT//[$'\t\r\n']}
        if [ $(cd .. && git clone $GIT_CLEANED) -lt 1]
        then
            echo "$GIT_CLEANED" >> $ERROR
            echo -e "\e[31m-$GIT_CLEANED"
         else
            echo "$GIT_CLEANED" >> $DONE
            echo -e "\e[32m+$GIT_CLEANED"
        fi
    done
    echo -e "\e[39m"
}
cat $TODO
loadGit
cat $ERROR