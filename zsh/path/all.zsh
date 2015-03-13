typeset -Ux path manpath

path=(
    ${DOTDIR}/bin
    ${GOPATH:+${GOPATH}/bin}(N/)
    /usr/local/opt/ruby/bin(N/)
    /opt/X11/bin(N/)
    /usr/local/{bin,sbin}
    /usr/{bin,sbin}
    /{bin,sbin}
)

manpath=(
    /usr/local/share/man
    /usr/share/man
)

# vim: filetype=zsh:ts=4:sw=4:expandtab
