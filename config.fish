. $HOME/.aliases

function prepath; set PATH $argv $PATH; end
function postpath; set PATH $PATH $argv; end

. $HOME/.env

set --erase fish_greeting
test -f $HOME/.ssh/environment; and . $HOME/.ssh/environment

command -v nvim >/dev/null 2>&1; and alias vim='nvim'
command -v fuck >/dev/null 2>&1; and eval (thefuck --alias | tr '\n' ';')
