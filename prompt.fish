function git_prompt
    set -l current_commit (git rev-parse --short HEAD 2> /dev/null)
    if test $status -gt 0
        return
    end
    git diff-files --quiet --ignore-submodules 2>/dev/null
    if test $status = 0
        set_color normal
    else
        set_color red
    end
    set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
    echo -n '['
    if test $branch = "HEAD"
        echo -n $current_commit
    else
        echo -n $branch
    end
    set untracked (git ls-files --other --directory --exclude-standard --no-empty-directory)
    test "$untracked"; and echo -n " U"
    git diff-index --cached --quiet HEAD --ignore-submodules --
    if test $status -gt 0
        echo -n " S"
    end
    echo -n ']'
end

function fish_prompt
    set -l last_status $status
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    git_prompt
    set_color normal
    if not test $last_status -eq 0
        set_color $fish_color_error
    end
    echo -n ' $ '
end

function fish_right_prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end
    echo -n -s "$USER" @ "$__fish_prompt_hostname"
end
