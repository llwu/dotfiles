# llwu/dotfiles
Here I version control my preferred configurations for various
software.  Many ideas/tricks/code snippets are taken from
other people's configurations.

## Management
I use
[GNU Stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
-- `stow $PROGRAM` installs the `$PROGRAM` configuration, and `stow
-D $PROGRAM` uninstalls the `$PROGRAM` configuration.

## Current Hosts
Some configs might be specific to the following systems.

1. Lenovo Y580 (2012)
    * Windows
    * Debian
        - KDE
        - `urxvt`
        - `fish`
        - `nvim`
    * Gentoo (Retired)
        - `xmonad`
        - `xmobar`
        - `urxvt`
        - `fish`
        - `nvim`
2. MacBook Retina (2015)
    * macOS
        - iTerm2
        - `fish`
        - `nvim`
3. Raspberry Pi 3 Model B (2016)
    * OSMC (based on Debian)
        - `tmux`
        - `bash`
        - `vim`
4. Athena Computing Environment
    * Debathena
        - `mosh-server`
        - `tmux`
        - `bash`
        - `vim`
