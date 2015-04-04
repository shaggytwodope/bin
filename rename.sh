#!/bin/bash
     # renames.sh
     # basic file renamer

for file in *.png
do
 mv "$file" "p${file%.png}.png"
done
for file in *.jpg
do
mv "$file" "p${file%.jpg}.jpg"

done