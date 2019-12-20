#!/bin/zsh

# zsh prompt/theming config

fpath=( ${ZDOTDIR}/themes/ ${fpath} )

typeset -Ax chars=(
    [branch]=''
    [right-arrow-filled]=''
    [right-arrow]=''
    [left-arrow-filled]=''
    [left-arrow]=''
)
typeset -Ag FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

spectrum_ls() {
    for code in {000..255}; do
        print -P -- "$code: %F{$code}Test%f%K{$code}Test%k"
    done
}

autoload -Uz promptinit
promptinit

if [[ -r ${ZDOTLOCAL}/themes.zsh ]]; then
    source "${ZDOTLOCAL}"/themes.zsh
fi
