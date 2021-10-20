#!/bin/sh

echo -e "======== Clean cache ========\n"

DEVS=`ls /var/lib/bluetooth`

for dev in $DEVS
do

    echo -e "\nIn directory: ${dev}"
    DIRS=`ls /var/lib/bluetooth/"${dev}"/`
    for dir in $DIRS
    do
        echo "${dir}"
        if [ $dir = "settings" ]; then
            echo "----No delete"
        elif [ $dir = "cache" ]; then
            echo "----Delete cache/*"
            rm -f /var/lib/bluetooth/"${dev}"/cache/*
        else
            echo "----Delete $dir"
            rm -rf /var/lib/bluetooth/"${dev}"/"${dir}"
        fi
    done

done

echo -e "======== Clean cache end ========\n"

