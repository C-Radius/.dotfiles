#!/bin/bash

#To activate something you have to uncomment all the continuous lines. 

#this is for debugging.
#exec /usr/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
#exec i3
wal -R
exec bspwm -c ~/.config/bspwm/bspwmrc

