#!/bin/sh
xrandr --output DP-0 --primary --mode 2560x1440 --pos 0x0 \
  --rotate normal --output DP-1 --off --output HDMI-0 --off \
  --output DP-2 --off --output eDP-1-1 --mode 2560x1440 \
  --pos 0x1440 --scale 0.6x0.6 --rotate normal
