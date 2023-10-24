#!/bin/bash
# Mounts psp into a random /tmp/ folder and writes the folder name into /tmp/psp_folder

SCRIPT_ROOT="/home/gus/psp_stuff/script"

partition=$($SCRIPT_ROOT/get_psp_partition.sh)
$SCRIPT_ROOT/check_error.sh

if [ ! -z "$(lsblk | grep $partition | awk '{print $7}')" ]; 
then 
    echo "ERROR: already mounted." 1>&2; 
    exit 1; 
fi

echo PSP Partition: /dev/$partition 1>&2

psp_folder=$(echo "/tmp/psp$RANDOM$RANDOM")

echo Temporary Mount Point: $psp_folder 1>&2

echo $psp_folder > /tmp/psp_folder

mkdir $psp_folder
$SCRIPT_ROOT/check_error.sh "Could not create psp mount folder."

sudo mount /dev/$partition $psp_folder
$SCRIPT_ROOT/check_error.sh "Could not mount psp."

echo "Successfully mounted psp!" 1>&2
exit 0
