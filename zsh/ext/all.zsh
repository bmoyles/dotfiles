[[ -f ${ZDOTDIR}/ext/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
	source ${ZDOTDIR}/ext/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(
    "main"
    "brackets"
    "pattern"
    "cursor"
    "root"
)

ZSH_HIGHLIGHT_STYLES=(
    "builtin" "bg=magenta,fg=black"
    "command" "bg=magenta,fg=black"
    "function" "bg=magenta,fg=black"
)

# vim: filetype=zsh:ts=4:sw=4:expandtab
