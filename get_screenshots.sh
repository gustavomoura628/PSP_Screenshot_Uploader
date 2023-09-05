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

SCRIPT_ROOT="/home/gus/psp_stuff/script"
dest_folder="/home/gus/psp_stuff/screenshots"

$SCRIPT_ROOT/mount_psp.sh
check_error 

psp_folder=$(cat /tmp/psp_folder)

cp $psp_folder/PSP/SCREENSHOT $dest_folder -r
check_error "Could not copy screenshot folder to pc."

echo "Successfully copied SCREENSHOT folder to pc!"

$SCRIPT_ROOT/umount_psp.sh
check_error

echo =========================================
echo ----You can safely unplug the psp now----
echo =========================================
exit 0
