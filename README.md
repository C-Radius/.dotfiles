My linux configuration files.

Configuration files for i3 wm, neovim, ranger, mpd, kitty, picom and more will
be put automatically in .config directory. An extra "Bin" Folder will be added
in home directory.

**WARNING**

In case someone does download this repo. InstallSystem.sh script will delete:

-   ~/Bin
-   ~/.icons
-   ~/.ncmpcpp
-   ~/.xinitrc
-   ~/.zshrc
-   ~/.zprofile
-   ~/.xdefaults
-   ~/.irssi
-   ~/.themes
-   ~/.config/i3
-   ~/.config/ranger
-   ~/.config/mpd
-   ~/.config/nvim
-   ~/.config/rofi
-   ~/.config/nitrogen
-   ~/.config/kitty
-   ~/.mpd
-   ~/.polybar
-   ~/.Thunar
-   ~/.picom.cfg
-   ~/.dunst

Keep that in mind before you download. 

.dotfiles

Clone the repo
do:
    `git submodules init`
    `git submodules update`

Use `InstallSystem.sh --help` for information on how to install packages and symlinks

Usage: InstallSystem.sh links

Will create the links for all config files.

