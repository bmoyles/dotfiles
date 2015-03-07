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

_set_gopath() {
  local dir=${PWD:A}
  while [[ -n ${dir} ]]; do
    if [[ -f ${dir}/.git ]]; then
      export GOPATH=${dir}
      break
    fi
    dir=${dir%/*}
  done
}

chpwd_functions=(${chpwd_functions[@]} "_set_gopath")


# vim: ft=zsh ts=2 sts=2 sw=2 expandtab
