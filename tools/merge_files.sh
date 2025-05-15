#!/bin/bash

# Ask user for input files (comma-separated)
INPUT_FILES=$(whiptail --title "Merge Files" --inputbox "Enter names of text files to merge (separated by space):" 10 70 "" 3>&1 1>&2 2>&3)

# Check if input is empty
if [ -z "$INPUT_FILES" ]; then
    whiptail --msgbox "No files entered. Returning to menu." 8 50
    exit
fi

# Ask for output file name
OUTPUT_FILE=$(whiptail --title "Output File" --inputbox "Enter name for the merged file (e.g. merged.txt):" 10 60 "merged.txt" 3>&1 1>&2 2>&3)

# Check if output name is empty
if [ -z "$OUTPUT_FILE" ]; then
    whiptail --msgbox "No output file name entered. Returning to menu." 8 50
    exit
fi

# Merge files (append all into one)
cat $INPUT_FILES > samples/$OUTPUT_FILE

# Confirm success
whiptail --msgbox "Files merged successfully into: samples/$OUTPUT_FILE" 10 60

