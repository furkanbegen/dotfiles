#!/bin/sh

# Get out of town if something errors
set -e

extern=HDMI-0

if xrandr | grep "$extern disconnected"; then
  xrandr --output HDMI-0 --off --output eDP-1-1 --primary --mode 2560x1440
	notify-send --urgency=low -t 5000 "Graphics Update" "External monitor disconnected"	
else 
  
  xrandr --output DP-0 --off --output DP-1 --off \
  --output HDMI-0 --primary --mode 3840x2160 --pos 0x0 --rotate normal \
  --output DP-2 --off --output eDP-1-1 --set "PRIME Synchronization" 1 \
  --mode 2560x1440 --scale 1.2x1.2 --pos 3840x0 --rotate normal --below HDMI-0
  notify-send --urgency=low -t 5000 "Graphics Update" "HDMI plugged in"
	exit
fi

