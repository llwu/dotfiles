# Options
setopt SH_WORD_SPLIT
setopt magic_equal_subst
setopt autopushd
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
bindkey -v '^?' backward-delete-char
bindkey -M viins 'jk' vi-cmd-mode
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man:*' menu yes select

# Sources
[ -f $HOME/.posixrc ] && . $HOME/.posixrc
[ -s $HOME/.zsh_prompt ] && source $HOME/.zsh_prompt
[ -s $HOME/minimal/minimal.zsh ] && . $HOME/minimal/minimal.zsh
[ -s $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    . $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -s /etc/zsh_command_not_found ] && . /etc/zsh_command_not_found
[ -f $HOME/.fzf.zsh ] && . $HOME/.fzf.zsh
return 0
