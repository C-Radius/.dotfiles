#!/bin/bash
SYNTAX='\nUsage: theme_changer.sh [mode] [image] [backend]\nMode: -l\t  - Light mode\n\t-d\t  - Dark mode\nImage: A valid path to an image.\n
backend: Backend to be used for color palete creation\n
Available backends:\n
\twal\n
\thaishoku\n
\tcolorthief\n'

if [[ $# == 0  ]] || [[ $# > 3 ]]; then
    echo -e $SYNTAX
    exit 1
fi

intensity=$1
image=$2
backend=$3

if [[ ! -z $backend ]]; then
    backend="--backend $backend"
else
    if [[ $intensity == "-l" ]]; then
        backend="--backend haishoku"
    else
        backend="--backend wal"
    fi
fi

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
    wal -q $backend -i $image
    #Modify vim settings to reflect our theme change
    sed -i 's/set background=.*$/set background=dark/g' ~/.config/nvim/init.vim
    #Select proper colors-rofi-{dark|light} file.
    cat ~/.cache/wal/colors-rofi-dark.rasi > ~/.config/rofi/theme.rasi
else
    #Execute wal with proper backend for light theme
    wal -q -l $backend -i $image
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

#Check if gtk config directory exists
if [ ! -d "$HOME/.config/gtk-3.0" ]; then
    cp -r /usr/share/gtk-3.0 $HOME/.config/gtk-3.0
fi

#Use oomox to generate the colorscheme for gtk
if [ -d "$HOME/themes/wal-gtk-theme" ]; then
    rm -rf $HOME/.themes/wal-gtk-theme
fi

/opt/oomox/plugins/theme_oomox/gtk-theme/change_color.sh -o wal-gtk-theme -d true -m all ~/.cache/wal/colors-oomox  1>/dev/null

#####Commented out because it interfers with auto_theme_changer.sh script
#####oomoxify asks for root password which interrupts the process
#Use oomoxify to generate colorscheme for spotify
#oomoxify-cli -g -s /opt/spotify/Apps ~/.cache/wal/colors-oomox

#modify gtk-3.0 settings to reflect our new theme.
sed -i 's/gtk-theme-name=.*$/gtk-theme-name=wal-gtk-theme/g' ~/.config/gtk-3.0/settings.ini 

wal-discord; beautifuldiscord --css ~/.cache/wal-discord/style.css

if [ -d $HOME/.config/spicetify ] && [ -d $HOME/.config/spicetify/Themes/wal ]; then
    spicetify apply update
fi

