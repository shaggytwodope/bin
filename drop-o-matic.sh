#!/bin/bash
# Simple autosort for downloads
find /riddlebox/Downloads/  -regextype posix-egrep -regex ".*\.(jpg|png|gif|jpeg|svg|tga|psd|jpe|bmp)$" -exec mv -n -t /riddlebox/miscimgs {} +
find /riddlebox/Downloads/  -regextype posix-egrep -regex ".*\.(deb|run|bin|rpm|sh|py)$" -exec mv -n -t /riddlebox/misc {} +
find /riddlebox/Downloads/  -regextype posix-egrep -regex ".*\.(diff|patch)$" -exec mv -n -t /riddlebox/misc {} +
find /riddlebox/Downloads/  -name "*.torrent" -exec mv -n -t /riddlebox/rt/watch {} +
find /riddlebox/Downloads/  -name "*.apk" -exec mv -n -t /riddlebox/run/android {} +
find /riddlebox/Downloads/  -name "*.jar" -exec mv -n -t /riddlebox/run/java {} +
find /riddlebox/Downloads/  -name "*.iso" -exec mv -n -t /riddlebox/misc {} +
find /riddlebox/Downloads/  -name "*.swf" -exec mv -n -t /riddlebox/misc {} +
find /riddlebox/Downloads/  -regextype posix-egrep -regex ".*\.(tar|zip|7z|rar|gz|xz|bz2|tgz)$" -exec mv -n -t /riddlebox/misc {} +
find /riddlebox/Downloads/  -regextype posix-egrep -regex ".*\.(pdf|djvu|txt|doc|docx|fb2|epub|rtf)$" -exec mv -n -t /riddlebox/Dropbox/Text {} +
find /riddlebox/Downloads/  -regextype posix-egrep -regex ".*\.(html|htm|mht|mhtml|chm|maff)$" -exec mv -n -t /riddlebox/Dropbox/Text/pages {} +
find /riddlebox/Downloads/  -regextype posix-egrep -regex ".*\.(ttf|otf|woff)$" -exec mv -n -t /riddlebox/misc {} +
find /riddlebox/Downloads/  -regextype posix-egrep -regex ".*\.(flv|mp4|avi|mkv|mov|webm|wmv)$" -exec mv -n -t /riddlebox/Vidoes {} +
find /riddlebox/Downloads/ -regextype posix-egrep -regex ".*\.(mp3|ogg|flac|sid|xm)$" -exec mv -n -t /riddlebox/Music {} +
exit 0
