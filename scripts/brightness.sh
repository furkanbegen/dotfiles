#!/bin/bash

max=100 #%
min=0   #%
step=0.05
display=HDMI-0

# List of all connected displays:
# all=$(xrandr -q | grep " connected" | awk '{print $1}')

case $1 in
  HDMI-0)
    curBr=$(xrandr --verbose | grep Brightness: | awk 'FNR==1{print $2}')
    ;;
  eDP-1-1)
    curBr=$(xrandr --verbose | grep Brightness: | awk 'FNR==2{print $2}') && display=eDP-1-1
  ;;
esac


case $2 in
    +)  val=$( echo "$curBr + $step" | bc )
        [[ $(echo "$val - ($max/100)" | bc | tr -d ".") -ge 0 ]] &&
        val=1
        ;;
    -)  val=$( echo "$curBr - $step" | bc )
        [[ $(echo "$val - ($min/100)" | bc | tr -d ".") -le 0 ]] &&
        val=0
        ;;
    *) exit;;

esac

xrandr --output $display --brightness $val

notify-send -h string:x-canonical-private-synchronous:anything \
            -t 1000 \
            " Screen Brightness: $display $( bc <<<"$val * 100"|sed 's/\..*//')%"
