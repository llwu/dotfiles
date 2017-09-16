setopt SH_WORD_SPLIT
setopt magic_equal_subst
setopt autopushd
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

SAVEHIST=1000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
HISTFILE=~/.zsh_history
bindkey -v '^?' backward-delete-char
bindkey -M viins 'jk' vi-cmd-mode
export KEYTIMEOUT=42

if [ -s ~/.zsh_prompt ] ; then
    MINIMAL_RPROMPT="no"
    source ~/.zsh_prompt
fi
[ -s ~/minimal/minimal.zsh ] && source ~/minimal/minimal.zsh
[ -s ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -s /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.posix ] && source ~/.posix
