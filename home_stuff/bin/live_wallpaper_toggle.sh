#!/bin/bash

process_id=$(pgrep -f xwinwrap)

if [ -z $process_id ]; then
    xwinwrap -a -g 1920x1080 -fs -sp -fs -nf -ov -- mplayer -speed 0.50 -quiet -loop 0 -nosound -wid WID $HOME/Videos/wallpaper.mp4
else
    kill $process_id
fi
