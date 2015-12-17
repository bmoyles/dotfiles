typeset -Ux path manpath

path=(
    ${DOTDIR}/bin
    ${DOTLOCAL}/python/bin(N/)
    ${GOPATH:+${GOPATH}/bin}(N/)
    ${GOROOT:+${GOROOT}/libexec/bin}(N/)
    /usr/local/{bin,sbin}
    /usr/{bin,sbin}
    /{bin,sbin}
)

manpath=(
    /usr/local/share/man
    /usr/share/man
)

# vim: filetype=zsh:ts=4:sw=4:expandtab
