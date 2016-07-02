function setenv; set -gx $argv; end
function prepath; set PATH $argv $PATH; end
function postpath; set PATH $PATH $argv; end
set --erase fish_greeting
command -v nvim >/dev/null 2>&1; and alias vim='nvim'
command -v fuck >/dev/null 2>&1; and eval (thefuck --alias | tr '\n' ';')
