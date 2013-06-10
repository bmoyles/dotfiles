fpath=( ${ZDOTDIR}/prompt/themes/ ${fpath} )

typeset -Ax chars
chars[branch]=''
chars[line]=''
chars[padlock]=''
chars[right-arrow-filled]=''
chars[right-arrow]=''
chars[left-arrow-filled]=''
chars[left-arrow]=''
chars[plus-minus]='±'
chars[hook-right-arrow]='➦'
chars[hook-left-arrow]='↩'
chars[check]='✔'
chars[x]='✘'
chars[ok]='🆗'
chars[new]='🆕'
chars[downarrow]='↓'
chars[uparrow]='↑'

typeset -Ag FX
FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f%K{$code}Test%k"
  done
}

autoload -Uz promptinit && promptinit

prompt bmoyles

# vim: ft=zsh sw=4 sts=4 ts=4 expandtab
