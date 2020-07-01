#!/bin/sh
currenttime=$(date +%H)
current_contrast="-l"

last_location=$(pwd)
cd ~/Pictures

new_wallpaper=$(ls *.{jpg,png,jpeg} |sort -R |tail -n 1)

if  [ $currenttime -ge 8 ] && [ $currenttime -lt 20 ]; then
    ~/bin/theme_changer.sh -l $new_wallpaper
else
    ~/bin/theme_changer.sh -d $new_wallpaper
fi

cd $last_location
