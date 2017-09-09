# llwu/dotfiles
Version control for my configs.
Credits to countless bloggers,
StackOverflow members, etc.

## Setup (Work in Progress)
```
$ make setup
```
will try to install the programs I use.
A good part of the configs I use will
still work without this.

## Install/Uninstall
I use
[GNU Stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
for management.

To install all configs at once:
```
$ make install
```
To uninstall all configs at once:
```
$ make uninstall
```
To clean out build artifacts:
```
$ make clean
```
To individually install a config for `$PACKAGENAME`:
```
stow $PACKAGENAME
```
To individually uninstall a config for `$PACKAGENAME`:
```
stow -D $PACKAGENAME
```

## Current Hosts
Machines I use, i.e. examples of what these configs might work on.

1. Lenovo Y580 (2012)
    * Windows - `bash`
    * Debian - KDE, `urxvt`, `fish`, `nvim`
    * Gentoo [Retired] - `xmonad`, `xmobar`, `urxvt`, `fish`, `nvim`
2. MacBook Retina (2015)
    * macOS - iTerm2, `zsh`, `nvim`
3. MacBook Pro
    * macOS - iTerm2, `zsh`, `nvim`
4. Thinkmate
    * Ubuntu 14.04 - `mosh-server`, `urxvt`, `tmux`, `zsh`, `nvim`
5. Intel NUC
    * Lubuntu - `tmux`, `zsh`, `vim`
6. Raspberry Pi 3 Model B (2016) [Retired]
    * OSMC - `tmux`, `bash`, `vim`
7. Athena Computing Environment [Retired]
    * Debathena - `mosh-server`, `tmux`, `bash`, `vim`
