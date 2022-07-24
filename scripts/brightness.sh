#!/bin/bash

maxBr=$(cat /sys/class/backlight/intel_backlight/max_brightness)
curBr=$(cat /sys/class/backlight/intel_backlight/brightness)

case $1 in
  +)  val=$( echo "$curBr + 10000" | bc)
        ;;
  -)  val=$( echo "$curBr - 10000" | bc)
        ;;
esac

#TODO improve for max and min values
echo $val >  /sys/class/backlight/intel_backlight/brightness

notify-send -h string:x-canonical-private-synchronous:anything \
            -t 1000 \
            " Screen Brightness: $val" 
