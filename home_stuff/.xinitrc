#!/bin/bash
systemctl --user set-environment DISPLAY=:0
systemctl --user set-environment DISPLAY=:1
start-pulseaudio-x11 &


if [ -d "$HOME/.cache/wal" ]; then
    wal -R
fi

exec dbus-launch bspwm -c ~/.config/bspwm/bspwmrc >.xsession-error 2>&1

if [[ -f /usr/share/applications/org.qutebrowser.qutebrowser.desktop ]] then
    xdg-mime default org.qutebrowser.qutebrowser.desktop x-scheme-handler/https x-shceme-handler/http
    xdg-settings set default-web-browser /usr/share/applications/org.qutebrowser.qutebrowser.desktop
fi

#exec plasmastart-x11

