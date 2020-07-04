#!/bin/sh

if [[ ! -z $1 ]]; then
    new_wallpaper=$1
fi

current_hour=$(date +%H)
current_month=$(date +%m)

#default to winter time
current_day_start_hour=8
current_day_end_hour=19

if [ "$current_month" -ge 6 ] && [ "$current_month" -le 8 ]; then
    current_day_start_hour=6
    current_day_end_hour=21
fi

current_contrast="-l"

if [[ -z $new_wallpaper  ]]; then
    new_wallpaper=$(ls ~/Pictures/*.{jpg,png,jpeg} |sort -R |tail -n 1)
fi

if  [ $current_hour -ge $current_day_start_hour ] && [ $current_hour -lt $current_day_end_hour ]; then
    ~/bin/theme_changer.sh -l $new_wallpaper
else
    ~/bin/theme_changer.sh -d $new_wallpaper
fi

