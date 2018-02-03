path=(
    ${DOTDIR}/bin
    ${DOTLOCAL}/bin(N/)
    ${DOTLOCAL}/powerline/bin(N/)
    ${GOPATH:+${GOPATH}/bin}(N/)
    ${GOROOT:+${GOROOT}/libexec/bin}(N/)
    /usr/local/{bin,sbin}
    /usr/{bin,sbin}
    /{bin,sbin}
)
typeset -U path
export PATH

manpath=(
    /usr/local/share/man
    /usr/share/man
)
typeset -U manpath
export MANPATH

# vim: filetype=zsh:ts=4:sw=4:expandtab
