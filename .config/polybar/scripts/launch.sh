#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

intern=eDP-1
extern=HDMI-1-0
extern2=DP-1-0

if xrandr | grep "$extern disconnected"; then
  MONITOR=$intern polybar --reload primary &
  MONITOR=$intern polybar --reload bottom&
else
  MONITOR=$extern2 polybar --reload primary &
  MONITOR=$extern polybar --reload secondary&
fi

echo "Bars launched..."
