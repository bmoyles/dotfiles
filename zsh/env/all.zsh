export MYVIMRC=${DOTDIR}/vim/vimrc
export VIMINIT="so ${MYVIMRC}"
export EDITOR="vim"
export VISUAL="vim"

export PAGER="less"
export LESS="-g -i -M -R -w"

export TZ="PST8PDT"

export PYENV_SHELL="zsh"

source ${ZDOTDIR}/env/tmux/tmux.zsh
source ${ZDOTDIR}/env/go/go.zsh
source ${ZDOTDIR}/env/python/python.zsh

# vim: ft=zsh ts=2 sts=2 sw=2 expandtab
