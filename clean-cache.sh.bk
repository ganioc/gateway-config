#!/bin/bash

echo -e "BT Clean Cache"

#str = hciconfig | grep "BD Address:" | awk 'print {1}'
#BT_MAC= `hciconfig | grep "BD Address:" | awk '{print $3}'`

BT_MAC=`hciconfig|grep "BD Address:"| grep -oE "[0-9A-Z]{2}:[0-9A-Z]{2}:[0-9A-Z]{2}:[0-9A-Z]{2}:[0-9A-Z]{2}:[0-9A-Z]{2}"`

echo -e "Get:$BT_MAC"

if [ -z "${BT_MAC}" ]; then
   echo "Wrong BT ADDR"
   echo "${BT_MAC}"
   exit 1
fi

echo "Extracted BT ADDR: ${BT_MAC}"
echo -e "Delete /var/lib/bluetooth/${BT_MAC}/cache"
#rm -f /var/lib/bluetooth/"${BT_MAC}"/cache/*

echo -e "Delete all dir under ${BT_MAC}"


#get BT MAC Address

DIRS=`ls /var/lib/bluetooth/"${BT_MAC}"/`
#echo -e "${DIRS}"

for dir in $DIRS
do
    echo "${dir}"
    #if [[ $dir != "cache"]] && [[ $dir != "settings"]]; then
#	echo "Delete it"
#
    #   fi
    if [ $dir = "cache" -o $dir = "settings" ]; then
	echo "No delete"

    else
	echo "Delete $dir"
	rm -rf /var/lib/bluetooth/"${BT_MAC}"/"${dir}"
    fi
    
done

echo -e "BT Clean Cache End"
