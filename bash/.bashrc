# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !
# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
fi

[ -s /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
[ -s /usr/share/bash-completion/completions/git ] && source /usr/share/bash-completion/completions/git
command -v brew >/dev/null 2>&1 && [ -f $(brew --prefix)/etc/bash_completion ] && source $(brew --prefix)/etc/bash_completion
command -v __git_complete >/dev/null 2>&1 && __git_complete g __git_main
[ -s ~/.posix ] && source ~/.posix
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
