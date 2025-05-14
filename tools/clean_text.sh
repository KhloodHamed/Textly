#!/bin/bash

# File: tools/clean.sh

filename=$1

# Check if file exists
if [[ ! -f "$filename" ]]; then
    echo "❌ File not found!"
    exit 1
fi

while true; do
    echo ""
    echo "🧹 Text Cleaning - Select an option:"
    echo "1. Remove special characters"
    echo "2. Remove empty lines"
    echo "3. Convert all text to lowercase"
    echo "4. Exit"
    read -p ">> " choice

    case $choice in
        1)
            echo "🧼 Removing special characters..."
            sed -i 's/[^a-zA-Z0-9 
]//g' "$filename"
            echo "✔️ Special characters removed."
            ;;
        2)
            echo "🧻 Removing empty lines..."
            sed -i '/^\s*$/d' "$filename"
            echo "✔️ Empty lines removed."
            ;;
        3)
            echo "🔡 Converting text to lowercase..."
            tr '[:upper:]' '[:lower:]' < "$filename" > temp && mv temp "$filename"
            echo "✔️ Text converted to lowercase."
            ;;
        4)
            echo "👋 Exiting text cleaning."
            break
            ;;
        *)
            echo "⚠️ Invalid option. Try again."
            ;;
    esac
done
