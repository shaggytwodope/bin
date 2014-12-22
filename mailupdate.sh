#!/usr/bin/env bash
# AUTHOR:   shaggy
# FILE:     mailupdate.sh
# ROLE:     TODO (some explanation)
# CREATED:  2014-12-21 18:12:50
# MODIFIED: 2014-12-21 18:16:42
offlineimap
cd /home/shaggy/Maildir
git add . 
git commit -am 'mailupdate'

