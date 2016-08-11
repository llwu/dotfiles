export LC_ALL="en_US.UTF-8"
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE="ibus"
ibus-daemon -drx
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
compton -Ccf -o 0.8 -D 6 --fade-exclude \
    "x = 0 && y = 0 && override_redirect = true" &
xautolock -detectsleep -corners ---- -time 5 -locker "slock" \
    -killtime 10 -killer \
    "dbus-send --system --print-reply --dest='org.freedesktop.UPower' \
    /org/freedesktop/UPower org.freedesktop.UPower.Suspend" &
ssh-agent -c | sed 's/^echo/#echo/' > $HOME/.ssh/environment
chmod 600 $HOME/.ssh/environment
xsetroot -cursor_name left_ptr
exec ck-launch-session dbus-launch bash -c "xmonad"
