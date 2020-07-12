#!/bin/bash

eval $(dbus-launch --sh-syntax --exit-with-session)

systemctl --user set-environment DISPLAY=:0
start-pulseaudio-x11 &

#jack_control start
#jack_control ds alsa
#jack_control dps device hw:HD2
#jack_control dps rate 48000
#jack_control dps nperiods 2
#jack_control dps period 64
#
#sleep 1
#a2jmidid -e &

if pgrep sxhkd; then killall sxhkd; fi
sxhkd &
setxkbmap -model pc105 -layout us,gr -variant qwerty -option grp:alt_shift_toggle &
setxkbmap us &

if pgrep picom; then killall picom; fi
picom --experimental-backends --backend glx &

if [ -d "$HOME/.cache/wal" ]; then
    wal -R 
fi

#/bin/dunst &
exec dbus-launch bspwm -c ~/.config/bspwm/bspwmrc >.xsession-error 2>&1

