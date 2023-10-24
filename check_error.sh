#!/bin/bash
#Checks return value and if false, prints error and exits with an error

function check_error() {
    r=$?
    error_message=$1
    if [ $r != 0 ];
    then 
        if ! [ -z "$error_message" ];
        then
            echo "ERROR: $error_message" 2>&1
        fi
        exit 1;
    fi
}
