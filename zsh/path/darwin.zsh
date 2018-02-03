path=(
  /usr/local/opt/coreutils/libexec/gnubin(N/)
  /usr/local/opt/gnu-tar/libexec/gnubin(N/)
  /usr/local/opt/gnu-sed/libexec/gnubin(N/)
  /usr/local/opt/ruby/bin(N/)
  /opt/X11/bin(N/)
  ${path}
)

manpath=(
  /usr/local/opt/coreutils/libexec/gnuman(N/)
  /usr/local/opt/gnu-tar/share/man(N/)
  /usr/local/opt/gnu-sed/libexec/gnuman(N/)
  ${manpath}
)

if (( ${+commands[python3]} )); then
  _py_user_base="$(python3 -msite --user-base)/bin"
  path=(
    ${_py_user_base}(N/)
    ${path}
  )
  unset _py_user_base
fi

if (( ${+commands[python2]} )); then
  _py_user_base="$(python2 -msite --user-base)/bin"
  path=(
    ${_py_user_base}(N/)
    ${path}
  )
  unset _py_user_base
fi

path=(
  ${HOME}/.local/powerline/bin(N/)
  ${path}
)
