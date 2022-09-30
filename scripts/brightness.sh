#!/bin/bash

maxBr=$(cat /sys/class/backlight/intel_backlight/max_brightness)
curBr=$(cat /sys/class/backlight/intel_backlight/brightness)

case $1 in
  +)  val=$( echo "$curBr + 10000" | bc)
        ;;
  -)  val=$( echo "$curBr - 10000" | bc)
        ;;
esac

#TODO consider negative value for min brightness 
variable=$(( $val > $maxBr ? $maxBr : $val ))
echo $variable >  /sys/class/backlight/intel_backlight/brightness

notify-send -h string:x-canonical-private-synchronous:anything \
            -t 1000 \
            " Screen Brightness: $variable" 
