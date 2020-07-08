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
if [[ -z $intensity ]]; then
    #Execute wal with proper backend for dark theme
    wal -q --backend wal -i $image
    #Modify vim settings to reflect our theme change
    sed -i 's/set background=.*$/set background=dark/g' ~/.config/nvim/init.vim
    #Select proper colors-rofi-{dark|light} file.
    cat ~/.cache/wal/colors-rofi-dark.rasi > ~/.config/rofi/theme.rasi
else
    #Execute wal with proper backend for light theme
    wal -q -l --backend haishoku -i $image
    #Modify vim settings to reflect our theme change
    sed -i 's/set background=.*$/set background=light/g' ~/.config/nvim/init.vim
    #Select proper colors-rofi-{dark|light} file.
    cat ~/.cache/wal/colors-rofi-light.rasi > ~/.config/rofi/theme.rasi
fi

# If qutebrowser is running, source the new colorscheme
if pgrep qutebrowser; then
    qutebrowser ':config-source'
fi

if pgrep dunst; then
    killall dunst
    notify-send test-string
fi

#Use oomox to generate the colorscheme for gtk
rm -rf ~/.themes/wal-gtk-theme
/opt/oomox/plugins/theme_oomox/gtk-theme/change_color.sh -o wal-gtk-theme -d true -m all ~/.cache/wal/colors-oomox  1>/dev/null

#####Commented out because it interfers with auto_theme_changer.sh script
#####oomoxify asks for root password which interrupts the process
#Use oomoxify to generate colorscheme for spotify
oomoxify-cli -g -s /opt/spotify/Apps ~/.cache/wal/colors-oomox

#modify gtk-3.0 settings to reflect our new theme.
sed -i 's/gtk-theme-name=.*$/gtk-theme-name=wal-gtk-theme/g' ~/.config/gtk-3.0/settings.ini 

wal-discord; beautifuldiscord --css ~/.cache/wal-discord/style.css
