#!/bin/bash

input_dir=""
output_dir=""
max_depth=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --max_depth)
            max_depth="$2"
            shift 2
            ;;
        *)
            if [[ -z "$input_dir" ]]; then
                input_dir="$1"
            else
                output_dir="$1"
            fi
            shift
            ;;
    esac
done

mkdir -p "$output_dir"

find_cmd="find \"$input_dir\" -type f"
if [[ -n "$max_depth" ]]; then
    find_cmd+=" -maxdepth $max_depth"
fi

eval "$find_cmd" | while read file; do
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