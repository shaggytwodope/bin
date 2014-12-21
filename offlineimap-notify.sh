#!/usr/bin/bash

#run OfflineIMAP once, with quiet interface
offlineimap -o -q -u quiet

#count new mail for every maildir
maildirnew="$HOME/Maildir/*/*/new/"
new="$(find $maildirnew -type f | wc -l)"

#count old mail for every maildir
maildirold="$HOME/Maildir/*/*/cur/"
old="$(find $maildirold -type f | wc -l)"

if [ $new -gt 0 ] 
then
    export DISPLAY=:0; export XAUTHORITY=~/.Xauthority; 
    notify-send -t 5000 -i /home/shaggy/bin/icons/smileicon.png -a "OfflineIMAP" "New: $new Old: $old"
fi