#!/bin/bash

while true; do
CHOICE=$(whiptail --title "🧰 Textly – Text Tools Suite" --menu "Select a tool:" 20 60 10 \
"1" "Text Analysis" \
"2" "Text Cleaning" \
"3" "Data Extraction" \
"4" "Text Transformation" \
"5" "Merge Files" \
"6" "Exit" 3>&1 1>&2 2>&3)

case $CHOICE in
  "1") bash tools/analyze_text.sh samples/sample.txt;;
  "2") bash tools/clean_text.sh samples/sample2.txt;;
  "3") bash tools/extract_data.sh sample/sample2.txt;;
  "4") bash tools/transform_text.sh sample/sample.txt ;;
  "5") bash tools/merge_files.sh ;;
  "6") clear; echo "Goodbye from Textly!"; exit ;;
  *) whiptail --msgbox "Invalid option!" 8 30 ;;
esac
done
