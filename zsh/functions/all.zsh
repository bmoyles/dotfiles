
local -a funcdirs
funcdirs=( ${ZDOTDIR}/functions/*(/N) )

fpath=( ${funcdirs} ${fpath})
typeset -U fpath
export FPATH

local func
for func in ${^funcdirs}/*(.N); do
    autoload -Uz ${func}(:t)
done
unset func
unset funcdirs

module_path=( ${module_path} /usr/local/lib/zpython(/N) )
typeset -U module_path
export MODULE_PATH

# vim: filetype=zsh:ts=4:sw=4:expandtab
