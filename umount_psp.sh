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

partition=$($SCRIPT_ROOT/get_psp_partition.sh)
check_error


if [ -z "$(lsblk | grep $partition | awk '{print $7}')" ]; 
then 
    echo "ERROR: Not mounted." 1>&2; 
    exit 1; 
fi

echo Umounting /dev/$partition... 1>&2

sudo umount /dev/$partition
check_error "Could not umount psp."

echo "Successfully umounted psp!" 1>&2
exit 0
