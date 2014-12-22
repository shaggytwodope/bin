#!/usr/bin/env bash
# AUTHOR:   shaggy
# FILE:     xkcd.sh
# ROLE:     TODO (some explanation)
# CREATED:  2014-12-21 18:17:01
# MODIFIED: 2014-12-21 19:17:14



img() {
wget -qO- xkcd.com | grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}' > .xkcd.url && wget -i .xkcd.url -q -O ~/.xkcd.img
}

text() {
wget -qO- xkcd.com|tee |grep -Po '(?<=(\w{3})" title=").*(?=" alt)' > ~/.xkcd.text
}

textshow() {
cat ~/.xkcd.text
}

img
text


textshow && sleep 10s && imgt ~/.xkcd.img




