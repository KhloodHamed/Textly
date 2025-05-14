#!/bin/bash

# File: tools/analyze.sh

filename=$1

# Check if file exists
if [[ ! -f "$filename" ]]; then
    echo "❌ File not found!"
    exit 1
fi

while true; do
    echo ""
    echo "🧠 Text Analysis - Select an option:"
    echo "1. Count total words"
    echo "2. Show top 3 most frequent words"
    echo "3. Count specific word occurrence"
    echo "4. Count total lines"
    echo "5. Exit"
    read -p ">> " choice

    case $choice in
        1)
            echo "🔢 Total number of words:"
            wc -w < "$filename"
            ;;
        2)
            echo "📊 Top 3 most frequent words:"
            tr -s '[:space:][:punct:]' '\n' < "$filename" | \
            grep -vE '^[[:space:]]*$' | \
            tr '[:upper:]' '[:lower:]' | \
            sort | uniq -c | sort -nr | head -3
            ;;
        3)
            read -p "🔍 Enter the word to search: " word
            count=$(grep -o -i "\b$word\b" "$filename" | wc -l)
            echo "The word '$word' occurred $count times."
            ;;
        4)
            echo "📏 Total number of lines:"
            wc -l < "$filename"
            ;;
        5)
            echo "👋 Exiting text analysis."
            break
            ;;
        *)
            echo "⚠️ Invalid option. Try again."
            ;;
    esac
done
