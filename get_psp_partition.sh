#!/bin/bash
# Gets PSP partition name

output=$(lsblk -fl | grep "vfat *FAT32 PSP" | perl -pe "s/(....).*/\1/")

if [ -z $output ]
then 
    echo "ERROR: Could not find PSP partition." 1>&2 
    exit 1
else 
    echo $output; 
    exit 0
fi
