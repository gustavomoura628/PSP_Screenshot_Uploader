#!/bin/bash
# Loops forever waiting for psp to connect
# If connected, runs screenshot extraction routines

SCRIPT_ROOT="/home/gus/psp_stuff/script"

previously_connected="false"
while true
do
    if [ -n "$(lsblk -fl | grep "FAT32 PSP")" ]
    then
        #echo connected 1>&2
        if [ "$previously_connected" = "false" ]
        then
            echo Detected connection 1>&2
            $SCRIPT_ROOT/send_to_telegram.sh
        fi
        previously_connected="true"
    else
        #echo not connected 1>&2
        if [ "$previously_connected" = "true" ]
        then
            echo Detected disconnection 1>&2
        fi
        previously_connected="false"
    fi
    sleep 1
done
