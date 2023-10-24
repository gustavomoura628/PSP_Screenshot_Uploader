#!/bin/bash
# Unmounts PSP

SCRIPT_ROOT="/home/gus/psp_stuff/script"

partition=$($SCRIPT_ROOT/get_psp_partition.sh)
$SCRIPT_ROOT/check_error.sh


if [ -z "$(lsblk | grep $partition | awk '{print $7}')" ]; 
then 
    echo "ERROR: Not mounted." 1>&2; 
    exit 1; 
fi

echo Umounting /dev/$partition... 1>&2

sudo umount /dev/$partition
$SCRIPT_ROOT/check_error.sh "Could not umount psp."

echo "Successfully umounted psp!" 1>&2
exit 0
