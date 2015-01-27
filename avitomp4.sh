#!/usr/bin/env bash
# AUTHOR:   shaggy
# FILE:     avitomp4.sh
# ROLE:     TODO (some explanation)
# CREATED:  2015-01-11 05:38:46
# MODIFIED: 2015-01-11 05:39:11
#!/bin/bash
for i in *.avi
do 
    ffmpeg -i "$i" "${i%avi}mp4" 
done
