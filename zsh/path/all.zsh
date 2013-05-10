typeset -Ux path manpath

path=(
    ${DOTDIR}/bin
    /usr/local/{bin,sbin}
    /usr/{bin,sbin}
    /{bin,sbin}
)

manpath=(
    /usr/local/share/man
    /usr/share/man
)

# vim: filetype=zsh:ts=4:sw=4:expandtab
