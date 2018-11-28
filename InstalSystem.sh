#!/bin/bash

CUR_DIR=$(pwd)

function show_help() {
    echo 'Usage: '
    echo '  --links     - Create symbolic links for configuration files in this repo to home directory'
    echo '  --packages  - Install packages in MyPackageList file to system.'
    echo '  --upl       - Update package list'
    echo '  --help      - Displays this information'
    exit 1
}




#Update package list file. 
function update_package_list ()
{
    echo "Updating package list..."
    sudo pacman -Qqen > MyPackageList
}




#This function should be used if you want to speed up the process
#of bringing your system back to how it was fast. Maybe after a re-install.
function install_packages () {
    sudo pacman -S $(< MyPackageList)
    yaourt -S oh-my-zsh-git
}




#WARNING: this function will replace(delete) your config files
#of neovim, awesome wm, ranger file manager, mpd music player.

#create sym links for everything in home except for .config file
#because it contains more stuff that we don't want to backup.
function create_symlinks () {
    echo "links option selected. Creating symlink..."

    rm -rf $HOME/.config/awesome $HOME/.config/nvim $HOME/.config/mpd $HOME/.config/ranger

    for x in $(ls -A $CUR_DIR/home_stuff);
    do
        if [ $x != ".config" ]; then
            echo "Creating symlink for $x. Link src: $CUR_DIR/home_stuff/$x to $HOME/$x"
            rm -r $HOME/$x
            ln -sf $CUR_DIR/home_stuff/$x $HOME/$x
        fi
    done

    if [ -d $HOME/.config ]; then
	echo ".config directory exists"
    else
	echo ".config directory doesn't exist... creating"
	mkdir $HOME/.config
    fi

    for x in $(ls -A $CUR_DIR/home_stuff/.config);
    do
        echo "Creating symlink for $x. Link src: $CUR_DIR/home_stuff/.config/$x $HOME/.config/$x"
        rm -r $HOME/.config/$x
        ln -sf $CUR_DIR/home_stuff/.config/$x $HOME/.config/$x
    done

    nvim Instructions
}




if [[ $# -eq 0  ]] ; then
    echo "No arguments were given"
    show_help
fi


for x in $@ ;
do
    if [ $x == "--links" ]; then
        let install_links=1
    elif [ $x == "--packages" ]; then
        let install_packages=1
    elif [ $x == "--upl" ]; then
        let install_upl=1
    elif [ $x == "--help" ]; then
        show_help
    else
        let install_other=1
    fi
done

if [ "$install_other" == "1" ]; then
    echo "Invalid argument was given"
    show_help
fi

echo "Starting Setup..."
echo "Working on $CUR_DIR..."

if [ "$install_packages" == "1" ]; then
    install_packages
fi

if [ "$install_links" == "1" ]; then
    create_symlinks
fi

if [ "$install_upl" == "1" ]; then
    update_package_list
fi
