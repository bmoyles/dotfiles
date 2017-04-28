typeset -a TMUXOPTS
TMUXCONF="${DOTDIR}/tmux"
TMUXRC="${TMUXCONF}/tmux.conf"
if (( ${+commands[tmux]} )); then
  TMUXVER=$(${commands[tmux]} -V | cut -f2 -d' ')
  if [[ -r ${TMUXCONF}/tmux${TMUXVER}.conf ]]; then
    TMUXRC=${TMUXCONF}/tmux${TMUXVER}.conf
  fi
fi
TMUXOPTS+=( -f ${TMUXRC} )
export TMUXOPTS TMUXCONF TMUXRC

# vim: ft=zsh ts=2 sts=2 sw=2 expandtab
