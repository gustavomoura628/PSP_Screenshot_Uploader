#!/bin/bash
# Copies SCREENSHOT folder to local folder

SCRIPT_ROOT="/home/gus/psp_stuff/script"
dest_folder="/home/gus/psp_stuff/screenshots"

$SCRIPT_ROOT/mount_psp.sh
$SCRIPT_ROOT/check_error.sh 

psp_folder=$(cat /tmp/psp_folder)

cp $psp_folder/PSP/SCREENSHOT $dest_folder -r
$SCRIPT_ROOT/check_error.sh "Could not copy screenshot folder to pc."

echo "Successfully copied SCREENSHOT folder to pc!"

$SCRIPT_ROOT/umount_psp.sh
$SCRIPT_ROOT/check_error.sh

echo =========================================
echo ----You can safely unplug the psp now----
echo =========================================
exit 0
