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
check_error "Could not create psp mount folder."

sudo mount /dev/$partition $psp_folder
check_error "Could not mount psp."

echo "Successfully mounted psp!" 1>&2
exit 0
