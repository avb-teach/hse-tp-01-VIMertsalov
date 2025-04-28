#!/bin/bash
input_dir="$1"
output_dir="$2"
mkdir -p "$output_dir"

find "$input_dir" -type f | while read file; do
    filename=$(basename "$file")
    a="$filename"
        if [ -f "$output_dir/$a" ]; then
        base="${filename%.*}"
        ext="${filename##*.}"
        counter=1
        while [ -f "$output_dir/${base}${counter}.$ext" ]; do
            ((counter++))
        done
                new_filename="${base}${counter}.$ext"
        cp "$file" "$output_dir/$new_filename"
    else
        cp "$file" "$output_dir/$a"
    fi  
done