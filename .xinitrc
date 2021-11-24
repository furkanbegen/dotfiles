#!/bin/sh
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto


intern=eDP-1-1
extern=HDMI-0

if xrandr | grep "$extern disconnected"; then
	xrandr --output eDP-1-1 --primary --mode 2560x1440
else
  xrandr --output DP-0 --off --output DP-1 --off \
  --output HDMI-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal \
  --output DP-2 --off --output eDP-1-1 --mode 2560x1440 --pos 3840x0 --rotate normal --below HDMI-0

fi

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

nitrogen --random ~/wallpapers --set-scaled
picom & rescuetime &
exec i3
