#!/bin/bash
PROCESS=trayer
number=$(pidof trayer)

if [ $number -gt 0 ]
    then
        kill $number
    else
	trayer --edge top --align right --widthtype request --heighttype pixel \
       --height 22 --expand true --tint 0x242424 --transparent true \
       --alpha 0 &
fi