#!/bin/sh

if pgrep polybar; then killall polybar; fi
polybar bspwm &
