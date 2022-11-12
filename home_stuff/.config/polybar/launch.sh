#! /bin/sh

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar bottom &

if [[ $(xrand -q | grep 'HDMI-1 connected') ]]; then
    polybar bottom_2 &
fi
