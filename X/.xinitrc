# background and cursor
xsetroot -solid "#16130f"
xsetroot -cursor_name left_ptr

# music
mopidy &

# terminals
[ -s ~/.Xresources ] && xrdb -merge ~/.Xresources
eval $COLORIZE
colorize
urxvtd -q -f -o

# i18n
export LC_ALL="en_US.UTF-8"
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE="ibus"
ibus-daemon -drx

# screen lock
xautolock -detectsleep -corners ---- \
    -notify 30 -notifier "xset dpms force off" \
    -time 5 -locker "slock" &

# color adjustment
redshift &

# make mouse disappear after 5 sec inactive
unclutter &

# ssh authentication
ssh-agent -c | sed 's/^echo/#echo/' > $HOME/.ssh/environment
#chmod 600 $HOME/.ssh/environment

# anything specific to this installation
[ -s ~/.xinitrc_local ] && source ~/.xinitrc_local

# launch xmonad
exec xmonad
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session xmonad

# vim: set ft=sh:
