setenv() { export "$1=$2"; }
prepath() { export PATH=$1:$PATH; }
postpath() { export PATH=$PATH:$1; }
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

command -v nvim >/dev/null 2>&1 && alias vim='nvim'
command -v fuck >/dev/null 2>&1 && eval "$(thefuck --alias)"
