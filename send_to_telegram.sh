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

$SCRIPT_ROOT/get_screenshots.sh
check_error

telegram_bot_upload_path="/home/gus/projects/telegrambot/sendImage.sh"
already_uploaded_file="/home/gus/psp_stuff/screenshots/already_uploaded.txt"
screenshots_path="/home/gus/psp_stuff/screenshots/SCREENSHOT"
touch $already_uploaded_file

already_uploaded=$(cat $already_uploaded_file)

files=$(find $screenshots_path | sort -h | grep "\.bmp$")

n_files=$(wc -l <<< $files)
n_files_digits=$(( $(wc -c <<< "$n_files") - 1 ))
echo n_files = $n_files, width = $n_files_digits
counter=1

for file in $files;
do
    printf "(%0${n_files_digits}d/$n_files) " $counter
    printf "Uploading $( echo $file | perl -pe "s|$screenshots_path/*||")... " 1>&2
    if [ -z "$(grep "^${file}$" <<< "$already_uploaded")" ]
    then
        while true
        do
            output=$(timeout 10 $telegram_bot_upload_path $file 2>/dev/null)
            #echo OUTPUT === $output
            if [ ! -z "$(echo $output | grep "\"ok\":true")" ]
            then
                echo Successfully sent image to telegram! 1>&2
                echo $file >> $already_uploaded_file
                break
            fi
        done
    else
        echo File already uploaded. 1>&2
    fi
    counter=$(( counter + 1 ))
done

echo =====================
echo --------Done!-------- 1>&2
echo =====================
exit 0
