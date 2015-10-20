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

typeset -Ux module_path
module_path=( ${module_path} /usr/local/lib/zpython )

# vim: filetype=zsh:ts=4:sw=4:expandtab
