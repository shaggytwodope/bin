#!/usr/bin/env bash
# AUTHOR:   shaggy
# FILE:     mailnotify.sh
# ROLE:     TODO (some explanation)
# CREATED:  2014-12-21 18:17:0
# MODIFIED: 2015-02-19 02:22:11

#count linuxlite mail for every maildir
maildirlite="$HOME/Maildir/lite/INBOX/new/"
lite="$(find $maildirlite -type f | wc -l)"


#count teknik mail for every maildir
maildirtek="$HOME/Maildir/teknik/INBOX/new/"
teknik="$(find $maildirtek -type f | wc -l)"

#count new gmail for every maildir
maildirgmail="$HOME/Maildir/gmail/INBOX/new/"
gmail="$(find $maildirgmail -type f | wc -l)"


    export DISPLAY=:0; export XAUTHORITY=~/.Xauthority; 
    notify-send -t 5000 -i /home/shaggy/bin/icons/smileicon.png -a "New Mail" "Gmail: $gmail Teknik: $teknik Linuxlite: $lite"
