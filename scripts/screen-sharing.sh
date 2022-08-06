#!/bin/sh

xrandr --output DP-0 --off --output DP-1 --off \
  --output DP-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
  --output DP-2 --off --output eDP-1-1 --set "PRIME Synchronization" 1 \
  --mode 2560x1440 --scale 0.6x0.6 --below DP-0
