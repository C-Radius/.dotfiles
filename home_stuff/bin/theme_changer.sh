#!/bin/bash
SYNTAX="theme_changer mode image 
where mode can be -l for light and -d for dark.
Image must be a valid path to an image file."

if [[ $# == 0  ]] || [[ $# > 2 ]]; then
    echo $SYNTAX
    exit 1
fi

intensity=$1
image=$2

if [[ -z $intensity  ]] && [[ $intensity != "-l" ]] && [[ $intensity != "-d" ]]; then
    echo "No dark or light mode specified"
    exit 1
fi

if [[ $intensity == "-d" ]]; then
    intensity=""
fi

if [[ -z $image  ]]; then
    echo "No image file specified"
    exit 1
fi

#Use wal to generate colorschemes
wal -q $intensity --backend haishoku -i $image

#Set dark or light mode for vim theme
if [[ $intensity == "-d" ]]; then
    sed -i 's/set background=.*$/set background=dark/g' ~/.config/nvim/init.vim
else
    sed -i 's/set background=.*$/set background=light/g' ~/.config/nvim/init.vim
fi


#Use oomox to generate the colorscheme for gtk
rm -rf ~/.themes/wal-gtk-theme
/opt/oomox/plugins/theme_oomox/gtk-theme/change_color.sh -o wal-gtk-theme -d true -m all ~/.cache/wal/colors-oomox  1>/dev/null

#modify gtk-3.0 settings to reflect our new theme.
sed -i 's/gtk-theme-name=.*$/gtk-theme-name=wal-gtk-theme/g' ~/.config/gtk-3.0/settings.ini 

if [[ $intensity == "-d" ]]; then
    cat ~/.cache/wal/colors-rofi-dark.rasi > ~/.config/rofi/theme.rasi
else
    cat ~/.cache/wal/colors-rofi-light.rasi > ~/.config/rofi/theme.rasi
fi

if pgrep dunst; then killall dunst; fi
exec dunst &

