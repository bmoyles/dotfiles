typeset -Ux fpath

local -a funcdirs
funcdirs=( ${ZDOTDIR}/functions/*(/N) )

fpath=( ${funcdirs} ${fpath})

local func
for func in ${^funcdirs}/*(.N); do
    autoload -Uz ${func}(:t)
done
unset func
unset funcdirs

# vim: filetype=zsh:ts=4:sw=4:expandtab
