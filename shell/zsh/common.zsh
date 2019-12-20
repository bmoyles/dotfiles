#!/bin/zsh

## zsh configuration common to both interactive and non-interactive shells
setopt nullglob

for __profile_d in /etc/profile.d/*.sh; do
    emulate sh -c "source ${__profile_d}"
done
unset __profile_d

for __common_cfg in "${DOTDIR}"/shell/common/*; do
    source "${__common_cfg}"
done
unset __common_cfg

if [[ -r ${ZDOTLOCAL}/common.zsh ]]; then
    source "${ZDOTLOCAL}"/common.zsh
fi
