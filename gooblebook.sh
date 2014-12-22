#!/usr/bin/env bash
# AUTHOR:   shaggy
# FILE:     gooblebook.sh
# ROLE:     TODO (some explanation)
# CREATED:  2014-12-22 12:37:04
# MODIFIED: 2014-12-22 12:37:13
goobook query $(echo $@ | sed -e 's:.*, *::') 
