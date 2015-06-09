#!/usr/bin/env bash

for file in 'cast' 'item' 'user' 'genre'; do
  awk 'NR != 2' "$file.tab" | awk 'NR != 2' | sed 's/,//g' | tr '\t' ',' > "$file.csv"
done

# Skip headers in data.tab because they contain illegal UTF-8 characters and are unnecessarry.
tail -n+4 data.tab | tr '\t' ',' > data.csv
