# /etc/skel/.bash_profile

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx > /dev/null 2>&1
fi

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

set +o history
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
