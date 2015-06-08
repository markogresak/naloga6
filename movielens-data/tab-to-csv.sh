#!/usr/bin/env bash

LC_ALL=C
for file in 'cast' 'data' 'item' 'user' 'genre'; do
  awk 'NR != 2' "$file.tab" | awk 'NR != 2' | sed 's/,//g' | tr '\t' ',' > "$file.csv"
done
