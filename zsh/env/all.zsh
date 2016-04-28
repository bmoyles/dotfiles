export MYVIMRC=${DOTDIR}/vim/vimrc
export VIMINIT="so ${MYVIMRC}"
export EDITOR="vim"
export VISUAL="vim"

export PAGER="less"
export LESS="-g -i -M -R -w"

export TZ="PST8PDT"

export LS_OPTIONS="-F"

export VIRTUAL_ENV_DISABLE_PROMPT="disable"

typeset -a TMUXOPTS
TMUXCONF="${DOTDIR}/tmux"
TMUXRC="${TMUXCONF}/tmux.conf"
[[ -r ${TMUXRC} ]] && TMUXOPTS+=( -f ${TMUXRC} )
export TMUXOPTS TMUXCONF TMUXRC

export GOPATH=~/work/golang
export GO15VENDOREXPERIMENT=1

export PYTHONUSERBASE=${HOME}/.local

# vim: ft=zsh ts=2 sts=2 sw=2 expandtab
