#!/usr/bin/bash



#count teknik mail for every maildir
maildirtek="$HOME/Maildir/teknik/INBOX/new/"
teknik="$(find $maildirtek -type f | wc -l)"

#count new gmail for every maildir
maildirgmail="$HOME/Maildir/gmail/INBOX/new/"
gmail="$(find $maildirgmail -type f | wc -l)"


    export DISPLAY=:0; export XAUTHORITY=~/.Xauthority; 
    notify-send -t 5000 -i /home/shaggy/bin/icons/smileicon.png -a "New Mail" "Gmail: $gmail Teknik: $teknik"
