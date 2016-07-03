setenv() { export "$1=$2"; }
prepath() { export PATH=$1:$PATH; }
postpath() { export PATH=$PATH:$1; }

colorized_user()
{
    local color='\033[01;32m'
    local body="$USER@$HOSTNAME"
    if [ $USER = "root" ]; then
        color='\033[01;31m'
        body="$HOSTNAME"
    fi
    printf "%b%s%b" "$color" "$body" "\033[00m"
}

git_prompt()
{
    local exit=$?
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return $exit
    local color=""
    local body="" 
    local commit="$(git rev-parse --short HEAD 2> /dev/null)"
    local branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    local untracked="$(git ls-files --other --directory \
        --exclude-standard --no-empty-directory)"
    git diff-files --quiet --ignore-submodules 2>/dev/null
    if [[ "$?" != 0 ]]; then
        color='\033[01;31m'
    else
        color='\033[00m'
    fi
    if [ $branch = "HEAD" ]; then
        body="$commit"
    else
        body="$branch"
    fi
    [[ "$untracked" ]] && body="$body U"
    git diff-index --cached --quiet HEAD --ignore-submodules -- || body="$body S"
    printf "%b[%s]%b " "$color" "$body" "\033[00m"
    return $exit
}

PS1='$(colorized_user)\[\033[01;34m\] \w $(git_prompt)\$\[\033[00m\] '

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
[ -f $HOME/.ssh/environment ] && source $HOME/.ssh/environment

command -v nvim >/dev/null 2>&1 && alias vim='nvim'
command -v fuck >/dev/null 2>&1 && eval "$(thefuck --alias)"
