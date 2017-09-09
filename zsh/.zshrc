setopt SH_WORD_SPLIT
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

set_window_title() {
    window_title="\e]0;${PWD/#"$HOME"/~}\a"
    echo -ne "$window_title"
}
precmd_functions=($precmd_functions set_window_title)

SAVEHIST=10000
HISTFILE=~/.zsh_history
bindkey -v
export KEYTIMEOUT=1

if [ -s ~/.zsh_prompt ] ; then
    MINIMAL_RPROMPT="no"
    source ~/.zsh_prompt
fi
[ -s ~/minimal/minimal.zsh ] && source ~/minimal/minimal.zsh
[ -s ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -s /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.posix ] && source ~/.posix
