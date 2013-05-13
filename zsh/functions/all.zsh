typeset -Ux fpath

local -a funcs
funcdirs=( ${ZDOTDIR}/functions/*(/N) )

fpath=( ${funcdirs} ${fpath})

local funcpath
for func in ${^funcdirs}/*(.N); do
    autoload -Uz ${func}(:t)
done
unset funcpath
unset funcs

# vim: filetype=zsh:ts=4:sw=4:expandtab
