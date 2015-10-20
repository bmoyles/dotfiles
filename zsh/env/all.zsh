export MYVIMRC=${DOTDIR}/vim/vimrc
export VIMINIT="so ${MYVIMRC}"
export EDITOR="vim"
export VISUAL="vim"

export PAGER="less"
export LESS="-g -i -M -R -w"

export TZ="PST8PDT"

export LS_OPTIONS="-F"

export VIRTUAL_ENV_DISABLE_PROMPT="disable"

typeset -ax TMUXOPTS
typeset -x TMUXRC
TMUXRC=${DOTDIR}/tmux/tmux.conf
[[ -r ${TMUXRC} ]] && TMUXOPTS=( -f ${TMUXRC} )

export GOPATH=~/work/golang

export PYTHONUSERBASE=~/.local/python

export POWERLINE_CONFIG_COMMAND=~/.local/python/bin/powerline-config

# vim: ft=zsh ts=2 sts=2 sw=2 expandtab
