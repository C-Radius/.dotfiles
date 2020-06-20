#!/bin/bash
wal -R
exec bspwm -c ~/.config/bspwm/bspwmrc 2>&1 .xsession-error

