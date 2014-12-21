#!/bin/bash
# Set maildirs
maildirs="$HOME/Maildir/gmail/INBOX/new/"

find $maildirs -type f | wc -l
exit 0