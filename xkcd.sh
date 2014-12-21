#!/bin/bash



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




