#!/usr/bin/env bash
# AUTHOR:   shaggy
# FILE:     bin/mp4tomp3.sh
# ROLE:     TODO (some explanation)
# CREATED:  2015-01-11 05:41:39
# MODIFIED: 2015-01-11 05:41:43
#!/bin/bash
for i in *.mp4
do 
    ffmpeg -i "$i" -ab 128k "${i%mp4}mp3" 
done
