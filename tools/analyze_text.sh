#!/bin/bash

filename=$1

if [[ ! -f "$filename" ]]; then
    whiptail --msgbox "File not found!" 8 40
    exit 1
fi
while true; do
CHOICE=$(whiptail --title "Text Analysis" --menu "Select an operation:" 15 50 5 \
"1" "Word Count" \
"2" "Top 3 Frequent Words" \
"3" "Count Specific Word" \
"4" "Line Count" \
"5" "Exit" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus -ne 0 ]; then
    whiptail --msgbox "Cancelled. Returning to menu." 8 40
    break
fi

case $CHOICE in
    1)
        wc -w < "$filename" > result.txt
        whiptail --title "Word Count" --textbox result.txt 10 40
        ;;
    2)
        tr -s '[:space:][:punct:]' '\n' < "$filename" | \
        grep -vE '^[[:space:]]*$' | \
        tr '[:upper:]' '[:lower:]' | \
        sort | uniq -c | sort -nr | head -3 > result.txt

        whiptail --title "Top 3 Words" --textbox result.txt 15 50
        ;;
    3)
        WORD=$(whiptail --inputbox "Enter word to search:" 8 40 "" 3>&1 1>&2 2>&3)
        exitstatus=$?
        if [ $exitstatus -ne 0 ]; then
           whiptail --msgbox "Cancelled. Returning to menu." 8 40
           continue
        fi
 
        COUNT=$(grep -o -i "\\b$WORD\\b" "$filename" | wc -l)
        echo "The word '$WORD' occurred $COUNT times." > result.txt
        whiptail --title "Word Count Result" --textbox result.txt 10 50
        ;;
    4)
        wc -l < "$filename" > result.txt
        whiptail --title "Line Count" --textbox result.txt 10 40
        ;;
    5)
        break
        ;;
    *)
        whiptail --msgbox "Invalid option." 8 40
         ;;
esac
done
