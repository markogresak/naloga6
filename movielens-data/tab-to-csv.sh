#!/usr/bin/env bash

for file in 'cast' 'data' 'item' 'user' 'genre'; do
  awk 'NR != 2' "$file.tab" | awk 'NR != 2' | LC_ALL=C tr '\t' ',' > "$file.csv"
done
