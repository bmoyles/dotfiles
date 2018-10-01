if (( ${+commands[powerline]} )); then
    POWERLINE_BIN="${commands[powerline]%/*}"
    if [[ ${POWERLINE_BIN} == *pyenv* ]]; then
        if [[ -x ${HOME}/.pyenv/versions/powerline/bin/powerline ]]; then
          POWERLINE_BIN="${HOME}/.pyenv/versions/powerline/bin"
        else
          POWERLINE_BIN="$(=pyenv which powerline)"
          POWERLINE_BIN="${POWERLINE_BIN%/*}"
        fi
    fi
    _python_cmd="$(head -1 ${POWERLINE_BIN}/powerline-daemon)"
    _python_cmd="${_python_cmd:2}"
    POWERLINE_BINDINGS="$("${_python_cmd}" -c 'from powerline.config import BINDINGS_DIRECTORY; print(BINDINGS_DIRECTORY)')"
    unset _python_cmd
    if [[ -d ${POWERLINE_BINDINGS:-} ]]; then
        export POWERLINE_AVAILABLE=1
        export POWERLINE_BIN
        export POWERLINE_COMMAND
        export POWERLINE_CONFIG_COMMAND
        export POWERLINE_BINDINGS
        export POWERLINE_ZSH_BINDINGS="${POWERLINE_BINDINGS}/zsh/powerline.zsh"
        export POWERLINE_TMUX_BINDINGS="${POWERLINE_BINDINGS}/tmux/powerline.conf"
    else
        unset \
          POWERLINE_BIN \
          POWERLINE_BINDINGS
        export POWERLINE_AVAILABLE=0
    fi
fi
