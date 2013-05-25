export MYVIMRC=${DOTDIR}/vim/vimrc
export VIMINIT="so ${MYVIMRC}"
export EDITOR="vim"
export VISUAL="vim"

export PAGER="less"
export LESS="-g -i -M -R -w"

export TZ="PST8PDT"

export LS_OPTIONS="-F"

typeset -ax TMUXOPTS
typeset -x TMUXRC
TMUXRC=${DOTDIR}/tmux/tmux.conf
[[ -r ${TMUXRC} ]] && TMUXOPTS=( -f ${TMUXRC} )

# vim: filetype=zsh:ts=4:sw=4:expandtab
