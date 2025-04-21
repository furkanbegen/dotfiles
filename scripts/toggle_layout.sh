#!/bin/bash

# Get the current layout
current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')

# Toggle between US and TR
if [ "$current_layout" = "us" ]; then
    setxkbmap -layout tr
else
    setxkbmap -layout us
fi

