#!/bin/bash

#To activate something you have to uncomment all the continuous lines. 
exec /usr/bin/start-pulseaudio-x11 &

#this is for debugging.
#exec /usr/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
exec compton -b -c &
exec awesome

#exec cinnamon-session

#exec i3

#exec i3-debug

#exec startxfce4

#exec startkde
