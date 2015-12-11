bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^f' edit-command-line

function insert_sudo {
  zle beginning-of-line
  zle -U 'sudo '
}
zle -N insert-sudo insert_sudo
bindkey '^[s' insert-sudo

#zle -N restart-zsh restart_zsh
bindkey -s '^[r' 'restart_zsh\n'

if [ -e /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# vim: filetype=zsh:ts=2:sw=2:expandtab
