#!/bin/bash

filename=$1

if [[ ! -f "$filename" ]]; then
    whiptail --msgbox "File not found!" 8 40
    exit 1
fi

while true; do
CHOICE=$(whiptail --title "Text Transformation" --menu "Choose an operation:" 15 50 5 \
"1" "Convert to UPPERCASE" \
"2" "Sort lines alphabetically" \
"3" "Reverse line order" \
"4" "Exit" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus -ne 0 ]; then
    whiptail --msgbox "Cancelled. Returning to menu." 8 40
    break
fi
case $CHOICE in
    1)
        tr '[:lower:]' '[:upper:]' < "$filename" > temp && mv temp "$filename"
        whiptail --msgbox "Converted all text to uppercase." 8 50
        ;;
    2)
        sort "$filename" > temp && mv temp "$filename"
        whiptail --msgbox "Lines sorted alphabetically." 8 50
        ;;
    3)
        tac "$filename" > temp && mv temp "$filename"
        whiptail --msgbox "Lines reversed in order." 8 50
        ;;
    4)
        break
        ;;
    *)
        whiptail --msgbox "Invalid option." 8 40
        ;;
esac
done
