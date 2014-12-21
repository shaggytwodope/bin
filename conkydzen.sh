#!/bin/sh
#echo "{\"version\":1}"
#echo "[[] ,"

echo "{\"version\": 1}"
echo "["
echo "[]"

FG='#FFF'
BG='#1c1c23'
FONT='-*-ProFont-*-*-*-*-11-*-*-*-*-*-*-*'
#conky -c ~/.i3/conkydzen | dzen2 -fg $FG -bg $BG -fn $FONT -x 500 -y 2 -w 3000 -ta r -xs 1


conky | dzen2 -x '500' -e '' -fg '#CCCACA' -bg '#242424' -ta r -fn '-*-dejavu sans-*-r-normal-*-13-120-*-*-*-*-iso8859-*' -y 0 -h 20 -p 

#conky -c ~/bin/conkyi3bar.sh | dzen2 -fg $FG -bg $BG -fn $FONT -x 500 -y 2 -w 3000 -ta r -xs 1
#conky -c ~/bin/conkyi3bar.sh | dzen2 -x '500' -e '' -fg '#CCCACA' -bg '#242424' -ta r -fn '-*-inconsolata-*-r-normal-*-12-120-*-*-*-*-iso8859-*' -y 0 -h 20 -p 

#conky -c /riddlebox/Downloads/conkytest | dzen2 -x '500' -e '' -fg '#CCCACA' -bg '#242424' -ta r -fn '-*-inconsolata-*-r-normal-*-12-120-*-*-*-*-iso8859-*' -y 0 -h 20 -p &

exit 0
