# llwu/dotfiles
Version control for my configs.
Credits to countless bloggers,
StackOverflow members, etc.

Should be usable on almost any system.

## Setup (Work in Progress)
```
$ make setup
```
will try to install the programs I use.
A good part of the configs I use will
still work without this.

Possibly ansible is a better solution here.

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
