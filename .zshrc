emulate sh
. ~/.bashrc
emulate zsh

autoload -Uz compinit
compinit

set_window_title() {
    window_title="\e]0;${PWD/#"$HOME"/~}\a"
    echo -ne "$window_title"
}

setopt prompt_subst
autoload -Uz vcs_info
RPROMPT='${vcs_info_msg_0_}%F{2}%n%F{5}@%m%f'
PROMPT='%F{3}%3~%f %# '

[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions vcs_info set_window_title)

source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
