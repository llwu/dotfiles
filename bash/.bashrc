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

setenv() { export "$1=$2"; }
prepath() { export PATH=$1:$PATH; }
append() { export "$1=$$1:$2"; }
if_exists_exec() { command -v $1 >/dev/null 2>&1 && shift && eval $@; }
if_exists_eval() { command -v $1 >/dev/null 2>&1 && shift && eval "$($@)"; }
if_exists_source() { [ -s $1 ] && source $1; }
if_exists_sh() { if_exists_source $1; }

if_exists_source $HOME/.common
if_exists_source $HOME/.platform
if_exists_source $HOME/.bash_prompt

cd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi
  builtin pushd "${DIR}" >/dev/null
}

alias flip='pushd >/dev/null'
alias prevd='popd >/dev/null'

if_exists_source /usr/local/etc/bash_completion
if_exists_source ~/.fzf.bash
if_exists_exec __git_complete __git_complete g __git_main
