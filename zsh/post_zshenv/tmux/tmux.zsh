typeset -gxa TMUXOPTS
typeset -gx TMUXVER
if (( ${+commands[tmux]} )); then
  TMUXVER=$(=tmux -V | cut -f2 -d' ')
  export TMUXVER
  if [[ -r ${TMUXCONF}/tmux${TMUXVER}.conf ]]; then
    TMUXRC=${TMUXCONF}/tmux${TMUXVER}.conf
  fi
fi
TMUXOPTS+=( -f ${TMUXRC} )
