if status --is-interactive
    function prepath; set PATH $argv $PATH; end
    function append; set -gx $argv[1] "$$argv[1]:$argv[2]"; end
    function if_exists_exec
        command -v $argv[1] >/dev/null 2>&1; and eval $argv[2..-1]
    end
    function if_exists_eval
        command -v $argv[1] >/dev/null 2>&1; and \
        eval (eval $argv[2..-1] | tr '\n' ';')
    end
    function if_exists_source; test -s $argv[1]; and source $argv[1]; end
    function if_exists_sh; test -s $argv[1]; and eval sh $argv[1]; end

    if_exists_source $HOME/.common
    if_exists_source $HOME/.platform
    if_exists_source $HOME/.fish_prompt
    set --erase fish_greeting
end
