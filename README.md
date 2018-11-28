My linux configuration files.

Configuration files for awesome wm, vim, ranger, mpd, urxvt will be put automatically in .config directory.
An extra "Bin" Folder will be added in home directory. 

**WARNING**

In case someone does download this repo. InstallSystem.sh script will delete:
-   ~/.config/awesome
-   ~/.config/ranger
-   ~/.config/mpd
-   ~/.config/nvim
-   ~/Bin

Keep that in mind before you download. 

.dotfiles

Clone the repo 
do:
    `git submodules init`
    `git submodules update`

Use `InstallSystem.sh --help` for information on how to install packages and symlinks

Usage: InstallSystem.sh links

Will create the links for all config files.

