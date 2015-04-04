#!/bin/bash

VOL=`mpc volume | sed '1 s/volume://'`
PERC=`echo $VOL`
VOLBAR=`echo -e "$PERC" | dzen2-gdbar -bg '#454545' -fg '#cd546c' -h 1 -w 50 | sed "s/\ .*\%//g"`

echo "$VOLBAR"

