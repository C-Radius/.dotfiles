#!/bin/bash
systemctl --user set-environment DISPLAY=:0
start-pulseaudio-x11 &

if pgrep picom; then killall picom; fi
picom --experimental-backends --backend glx &

if [ -d "$HOME/.cache/wal" ]; then
    wal -R 
fi

exec dbus-launch bspwm -c ~/.config/bspwm/bspwmrc >.xsession-error 2>&1

