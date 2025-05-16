#!/bin/bash

filename=$1

# Check if file exists
if [[ ! -f "$filename" ]]; then
    whiptail --msgbox "File not found!" 8 40
    exit 1
fi

while true; do
CHOICE=$(whiptail --title "Text Cleaning" --menu "Choose an operation:" 15 50 5 \
"1" "Remove special characters" \
"2" "Remove empty lines" \
"3" "Convert to lowercase" \
"4" "Exit" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus -ne 0 ]; then
    whiptail --msgbox "Cancelled. Returning to menu." 8 40
    break
fi
case $CHOICE in
    1)
        sed -i 's/[^a-zA-Z0-9 \n]//g' "$filename"
        whiptail --msgbox "Special characters removed from file." 8 50
        ;;
    2)
        sed -i '/^\s*$/d' "$filename"
        whiptail --msgbox "Empty lines removed from file." 8 50
        ;;
    3)
        tr '[:upper:]' '[:lower:]' < "$filename" > temp && mv temp "$filename"
        whiptail --msgbox "All text converted to lowercase." 8 50
        ;;
    4)
        exit 0
        ;;
    *)
        whiptail --msgbox "Invalid option." 8 40
        ;;
esac
done

