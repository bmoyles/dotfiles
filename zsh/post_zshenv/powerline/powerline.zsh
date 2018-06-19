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
    POWERLINE_BINDINGS="$("${POWERLINE_BIN}"/python -c 'from powerline.config import BINDINGS_DIRECTORY; print(BINDINGS_DIRECTORY)')"
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
