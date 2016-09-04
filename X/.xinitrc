# background and cursor
nitrogen --restore
xsetroot -cursor_name left_ptr

# music
mopidy &

# terminals
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
urxvtd -q -f -o

# color adjustment
redshift &

# transparency and shadows
compton -cf -o 0.8 -D 6 --fade-exclude \
    "x = 0 && y = 0 && override_redirect = true" &

# screen lock and powersave
xautolock -detectsleep -corners ---- \
    -notify 30 -notifier "xset dpms force off" \
    -time 5 -locker "slock" &

# ssh authentication
ssh-agent -c | sed 's/^echo/#echo/' > $HOME/.ssh/environment
#chmod 600 $HOME/.ssh/environment

# i18n
export LC_ALL="en_US.UTF-8"
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE="ibus"
ibus-daemon -drx

# launch xmonad
exec xmonad
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session xmonad
