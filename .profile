source $HOME/.aliases

setenv() { export "$1=$2"; }
prepath() { export PATH=$1:$PATH; }
postpath() { export PATH=$PATH:$1; }

source $HOME/.env

bash_prompt() {
    local exit=$?
    local red="\033[01;31m"
    local green="\033[01;32m"
    local blue="\033[01;34m"
    local clear="\033[0m"
    case $1 in
        user_host_dir)
            if [ $USER = "root" ]; then
                echo -ne "\[$red\]"
            else
                echo -ne "\[$green\]"
                echo -ne "\\u@"
            fi
            echo -n "\\h"
            echo -ne "\[$blue\]"
            echo -n " \\w "
            ;;
        git_color)
            git diff-files --quiet --ignore-submodules 2>/dev/null
            if [[ "$?" != 0 ]]; then
                echo -e $red
            else
                echo -e $clear
            fi
            ;;
        git_branch)
            git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return $exit
            local body=""
            local commit="$(git rev-parse --short HEAD 2> /dev/null)"
            local branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
            local untracked="$(git ls-files --other --directory \
                --exclude-standard --no-empty-directory)"
            if [ $branch = "HEAD" ]; then
                body="$commit"
            else
                body="$branch"
            fi
            [[ "$untracked" ]] && body="$body U"
            git diff-index --cached --quiet HEAD --ignore-submodules -- || body="$body S"
            printf "[%s] " "$body"
            return $exit
            ;;
        prompt_color)
            if [[ "$exit" != 0 ]]; then
                echo -e $red
            else
                echo -e $clear
            fi
            ;;
    esac
    return $exit
}
PS1="$(bash_prompt user_host_dir)\
\[\$(bash_prompt git_color)\]\$(bash_prompt git_branch)\
\[\$(bash_prompt prompt_color)\]\\$\[\033[0m\] "
export PS1

cd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi
  builtin pushd "${DIR}" >/dev/null
}

bash_prompt
alias flip='pushd >/dev/null'
alias prevd='popd >/dev/null'
[ -f $HOME/.ssh/environment ] && source $HOME/.ssh/environment

command -v nvim >/dev/null 2>&1 && alias vim='nvim'
command -v fuck >/dev/null 2>&1 && eval "$(thefuck --alias)"
