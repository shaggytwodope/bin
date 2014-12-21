#!/bin/bash
# Set maildirs
maildirs="$HOME/Maildir/teknik/INBOX/new/"

find $maildirs -type f | wc -l
exit 0