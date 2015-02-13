#!/usr/bin/env bash
# AUTHOR:   shaggy
# FILE:     archofflinewikisearch.sh
# ROLE:     TODO (some explanation)
# CREATED:  2015-02-12 15:54:16
# MODIFIED: 2015-02-12 15:55:48

cd /usr/share/doc/arch-wiki/html/
grep -i "$1" index.html | sed 's/.*HREF=.\(.*\.html\).*/\1/g' | xargs opera -newpage
