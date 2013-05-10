typeset -Ux fpath

local -a funcs
funcs=( ${ZDOTDIR}/functions/*(/N) )

fpath=( ${funcs} ${fpath})

local funcpath
for funcpath in ${^funcs}/*(.N); do
    autoload -Uz ${funcpath}(:t)
done
unset funcpath
unset funcs

# vim: filetype=zsh:ts=4:sw=4:expandtab
