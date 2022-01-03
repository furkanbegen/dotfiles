#!/bin/sh
xrandr --output DP-0 --off --output DP-1 --off \
  --output HDMI-0 --primary --mode 3840x2160 --pos 0x0 --rotate normal \
  --output DP-2 --off --output eDP-1-1 --set "PRIME Synchronization" 1 \
  --mode 2560x1440 --scale 1.2x1.2 --pos 3840x0 --rotate normal --below HDMI-0

