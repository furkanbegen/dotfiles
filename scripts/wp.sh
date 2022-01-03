#!/bin/bash

# Source: https://crunchbang.org/forums/viewtopic.php?pid=391690#p391690
# Select random wallpaper for each screen, by fiddling with the configuration file for nitrogen.
# TODO: Modify to use getops, allowing you to specify config file locations, etc.
# TODO: Modify to use an RC file, so that rather than looking at hardcoded shit in this script you go somewhere else. 

CONFIG="$HOME/.config/nitrogen/bg-saved.cfg" # Replace this with whatever the nitrogen config file is.
WALLPAPERDIR="$HOME/wallpapers/"

function setwallpaper {
    # Modify the nitrogen configuration file (default location set in $CONFIG).
    # $1: Line to modify
    # TODO: Modify it so that rather than use a line to modify this, we just use the screen name.
    # Other potential features: allow you to use different modes rather than centre-and-zoom.
    WALLPAPER=`find $WALLPAPERDIR -type f | grep -E "jpeg|jpg|png" | shuf -n1`
    echo "$(date -u) -- Setting line $1 to $WALLPAPER."
    sed -i "$1 c\file=$WALLPAPER" $CONFIG
    }

setwallpaper 2   # screen 1, defined in line #7
setwallpaper 7   # screen 2, defined in line #12

# Refresh Nitrogen with new wallpaper.
nitrogen --restore
