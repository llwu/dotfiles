setenv() { export "$1=$2"; }
prepath() { export PATH=$1:$PATH; }
postpath() { export PATH=$PATH:$1; }
if_exists_exec() { command -v $1 >/dev/null 2>&1 && shift && $@; }
if_exists_eval() { command -v $1 >/dev/null 2>&1 && shift && eval "$($@)"; }
if_exists_source() { [ -s $1 ] && source $1; }
if_exists_sh() { if_exists_source $1; }

if_exists_source $HOME/.common
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
