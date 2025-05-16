#!/bin/bash

while true; do
CHOICE=$(whiptail --title "🧰 Textly – Text Tools Suite" --menu "Select a tool:" 20 60 10 \
"1" "Text Analysis" \
"2" "Text Cleaning" \
"3" "Data Extraction" \
"4" "Text Transformation" \
"5" "Merge Files" \
"6" "Exit" 3>&1 1>&2 2>&3)

exitstatus=$?


if [ $exitstatus -ne 0 ]; then
    whiptail --msgbox "Exiting Textly. Goodbye!" 8 40
    clear
    exit 0
fi

case $CHOICE in
  "1") filename=$(whiptail --inputbox "Enter the file path to analyze:" 8 60 "" 3>&1 1>&2 2>&3)
       [ $? -ne 0 ] && continue  # إذا ضغط Cancel 
       bash tools/analyze_text.sh $filename;;
  "2") filename=$(whiptail --inputbox "Enter the file path to clean:" 8 60 "" 3>&1 1>&2 2>&3)
       [ $? -ne 0 ] && continue
       bash tools/clean_text.sh $filename;;
  "3") filename=$(whiptail --inputbox "Enter the file path to extract:" 8 60 "" 3>&1 1>&2 2>&3)
       [ $? -ne 0 ] && continue
       bash tools/extract_data.sh $filename;;
  "4") filename=$(whiptail --inputbox "Enter the file path to transform:" 8 60 "" 3>&1 1>&2 2>&3)
       [ $? -ne 0 ] && continue
       bash tools/transform_text.sh $filename ;;
  "5") bash tools/merge_files.sh ;;
  "6") clear; 
       echo "Goodbye from Textly!"; 
       exit ;;
    *) whiptail --msgbox "Invalid option!" 8 30 ;;
esac
done
