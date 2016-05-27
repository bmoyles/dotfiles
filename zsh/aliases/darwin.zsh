if [[ ${commands[ls]} == *gnubin* ]]; then
  alias ls='ls -F --color=auto'
elif (( ${+commands[gls]} )); then
  alias ls='gls -F --color=auto'
else
  alias ls='ls -F -G'
fi
