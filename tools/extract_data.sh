#!/bin/bash

filename=$1


if [[ -z "$filename" ]]; then
    filename=$(whiptail --inputbox "Enter path to the file:" 8 60 "samples/sample.txt" 3>&1 1>&2 2>&3)
    exitstatus=$?
    if [ $exitstatus -ne 0 ]; then
        whiptail --msgbox "Cancelled. Returning to main menu." 8 40
        exit 0
    fi
fi


if [[ ! -f "$filename" ]]; then
    whiptail --msgbox "File not found!" 8 40
    exit 1
fi

while true; do
CHOICE=$(whiptail --title "Data Extraction" --menu "Choose an extraction type:" 15 50 5 \
"1" "Extract Emails" \
"2" "Extract Phone Numbers" \
"3" "Extract lines with specific word" \
"4" "Exit" 3>&1 1>&2 2>&3)
exitstatus=$?


if [ $exitstatus -ne 0 ]; then
    whiptail --msgbox "Cancelled. Returning to main menu." 8 40
    break
fi

case $CHOICE in
    1)
        grep -E -o "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" "$filename" > result.txt
        whiptail --title "Emails Found" --textbox result.txt 15 50
        ;;
    2)
        grep -E -o "\+?[0-9]{2,3}[- ]?[0-9]{2,3}[- ]?[0-9]{4,}" "$filename" > result.txt
        whiptail --title "Phone Numbers Found" --textbox result.txt 15 50
        ;;
    3)
        WORD=$(whiptail --inputbox "Enter the word to search for:" 8 40 "" 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus -ne 0 ]; then
            whiptail --msgbox "Cancelled search. Returning to menu." 8 40
            continue
        fi
        grep -i "$WORD" "$filename" > result.txt
        whiptail --title "Lines Matching '$WORD'" --textbox result.txt 15 50
        ;;
    4)
        break
        ;;
    *)
        whiptail --msgbox "Invalid option." 8 40
        ;;
esac
done
