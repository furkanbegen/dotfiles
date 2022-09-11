#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

intern=eDP-1-1
extern=DP-0

if xrandr | grep "$extern disconnected"; then
  MONITOR=$intern polybar --reload top &
  MONITOR=$intern polybar --reload bottom&
else
  MONITOR=$extern polybar --reload top &
  MONITOR=$extern polybar --reload bottom&
  MONITOR=$intern polybar --reload secondary &
fi

echo "Bars launched..."
