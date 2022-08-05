#!/bin/sh

# Get out of town if something errors
set -e

extern=DP-0

if xrandr | grep "$extern disconnected"; then
  xrandr --output DP-0 --off --output eDP-1-1 --primary --mode 2560x1440 \
    --scale 0.6x0.6
	notify-send --urgency=low -t 5000 "Graphics Update" "External monitor disconnected"	
else 
  
  xrandr --output HDMI-0 --off --output DP-1 --off \
  --output DP-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal \
  --output DP-2 --off --output eDP-1-1 --set "PRIME Synchronization" 1 \
  --mode 2560x1440 --scale 0.6x0.6 --pos 3840x0 --rotate normal --below DP-0
  notify-send --urgency=low -t 5000 "Graphics Update" "Display Port plugged in"
	exit
fi

