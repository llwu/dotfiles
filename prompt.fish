function git_prompt
    set -l current_commit (git rev-parse --short HEAD 2> /dev/null)
    test $status -gt 0; and return
    set -l body ""
    set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
    set untracked (git ls-files --other --directory --exclude-standard --no-empty-directory)
    git diff-files --quiet --ignore-submodules 2>/dev/null
    if test $status = 0
        set_color normal
    else
        set_color red
    end
    if test $branch = "HEAD"
        set body $current_commit
    else
        set body $branch
    end
    test "$untracked"; and set body "$body U"
    git diff-index --cached --quiet HEAD --ignore-submodules --; or set body "$body S"
    printf "[%s]" "$body"
    set_color normal
end

function fish_prompt
    set -l last_status $status
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    git_prompt
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
