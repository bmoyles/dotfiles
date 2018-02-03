#!/usr/bin/env bash

set -eu

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: " "$@" >&2
}

log() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: " "$@" >&1
}

: ${DOTDIR:=${HOME}/.dotfiles}
: ${DOTREPO:="https://github.com/bmoyles/dotfiles.git"}
: ${DOTLOCAL=${HOME}/.local}
: ${OS:=$(uname -s)}
readonly DOTDIR DOTREPO DOTLOCAL OS
export DOTDIR DOTREPO DOTLOCAL OS


move_existing_dotfiles() {
  local -r datestamp=$(date '+%Y%m%d%H%M%S')
  local dotdir_backup="${DOTDIR}.bak.${datestamp}"

  if [[ -d ${DOTDIR} ]]; then
    log "Found existing dotfiles at ${DOTDIR}"
    log "Moving ${DOTDIR} to ${dotdir_backup}"
    mv -f ${DOTDIR} ${dotdir_backup}
  elif [[ -e ${DOTDIR} ]]; then
    err "DOTDIR path ${DOTDIR} exists but is not a directory, review and try again"
    exit 1
  fi
}


clone_fresh_dotfiles() {
  log "Cloning dotfiles repo ${DOTREPO} to ${DOTDIR}"
  git clone ${DOTREPO} ${DOTDIR}
}


setup_zsh() {
  local -r datestamp=$(date '+%Y%m%d%H%M%S')
  local -r zshenv_src="${DOTDIR}/zsh/zshenv.home"
  local -r zshenv_dst=~/.zshenv
  local -r zshenv_backup="${zshenv_dst}.bak.${datestamp}"

  if [[ -e ${zshenv_dst} && ! -L ${zshenv_dst} ]]; then
    log "Existing zshenv found at ${zshenv_dst}, renaming to ${zshenv_backup}"
    mv -f ${zshenv_dst} ${zshenv_backup}
  fi
  log "Linking ${zshenv_src} to ${zshenv_dst}"
  ln -sf ${zshenv_src} ${zshenv_dst}
}


setup_config() {
  local -r datestamp=$(date '+%Y%m%d%H%M%S')
  local config_src

  log "Linking config dirs"

  if [[ ! -d ~/.config ]]; then
    log "directory ~/.config does not exist, creating"
    mkdir -p ~/.config
  fi

  for config_src in ${DOTDIR}/config/*; do
    local config_basename
    local config_dst
    local config_backup

    config_basename=$(basename ${config_src})
    config_dst=~/.config/${config_basename}
    if [[ -e ${config_dst} ]]; then
      log "${config_dst} exists"
      if [[ -L ${config_dst} ]]; then
        log "${config_dst} is a symlink, removing"
        rm -f ${config_dst}
      elif [[ -d ${config_dst} || -f ${config_dst} ]]; then
        config_backup="${config_dst}.bak.${datestamp}"
        log "${config_dst} is a file or directory, backing up to ${config_backup}"
        mv -f ${config_dst} ${config_backup}
      fi
    fi
    log "linking ${config_src} to ${config_dst}"
    ln -sf ${config_src} ${config_dst}
    unset config_basename config_dst config_backup
  done
}

use_zsh() {
  local -r profile=~/.profile
  local -r profile_backup=${profile}.bootstrap

  PATH=/usr/local/bin:/usr/bin:/bin
  if which zsh > /dev/null; then
    ZSH_PATH=$(which zsh)
    if [[ -e ${profile} ]]; then
      log "Existing .profile found"
      if [[ -e ${profile_backup} ]]; then
        log "Existing ${profile_backup} found, ${profile} will be overwritten"
      else
        if [[ -L ${profile} ]]; then
          log "${profile} is a symlink, removing"
          rm -f "${profile}"
        else
          log "Renaming existing ${profile} to ${profile_backup}"
          mv -f ${profile} ${profile_backup}
        fi
      fi
    fi
    log "Writing .profile to enable zsh w/o chsh"
    cat <<EOF > ${profile}
# if we aren't already in zsh...
case "\${SHELL}" in
  *zsh)
    # we've already exec'd zsh or used chsh. noop.
    :
    ;;
  *)
    # for all other shells, check for NO_ZSH and ~/.no_zsh before switching
    # so we can disable auto-switch to zsh if need be
    if [[ -n "\${NO_ZSH}" || -e "\${HOME}/.no_zsh" || ( ! -x /usr/local/bin/zsh && ! -x /bin/zsh ) ]]; then
      if [[ -e ${profile_backup} ]]; then
        # if we've got a profile backup, pull that in
        . ${profile_backup}
      fi
    else
      # no sign of NO_ZSH or ~/.no_zsh, exec time!
      export SHELL=${ZSH_PATH}
      exec ${ZSH_PATH} -d -l
    fi
    ;;
esac
EOF
  else
    err "zsh not found on path ${PATH}"
  fi
}

install_powerline() {
  log "Attempting to install powerline"
  local powerline_venv="${DOTLOCAL}/powerline"
  local -a powerline_libs=( pyuv pygit2 )
  local python
  if ! python=$(which python3); then
    err "Unable to find python3"
    return 1
  fi

  log "Building powerline virtualenv under ${powerline_venv}"
  "${python}" -mvenv --without-pip "${powerline_venv}"
  "${powerline_venv}/bin/python3" "${DOTLOCAL}/get-pip.py"
  "${powerline_venv}/bin/python3" -mpip install -U pip setuptools wheel
  log "Installing powerline into ${powerline_venv}"
  if "${powerline_venv}/bin/python3" -mpip install -U powerline-status; then
    log "Powerline installed"
    log "Attempting to install extra libraries for powerline"
    local _lib
    for _lib in "${powerline_libs[@]}"; do
      log "Attempting to install lib ${_lib}"
      if ! "${powerline_venv}/bin/python3" -mpip install -U "${_lib}"; then
        err "Unable to install lib ${_lib}, check dependencies adn pip output"
      else
        log "Successfully installed lib ${_lib}"
      fi
    done
  else
    err "Unable to install powerline, check dependencies and pip output"
  fi
}

viminit() {
  local _vim
  if ! _vim=$(which vim 2>/dev/null); then
    log "vim not found, not initializing vim"
    return
  fi
  readonly _vim
  log "Initializing vim"
  pushd ${DOTDIR} > /dev/null 2>&1
  git submodule update --init --recursive
  vim +PluginInstall +qall
  popd > /dev/null 2>&1
}

os_specific_tasks() {
  log "Looking for os-specific tasks"

  # lowercase $OS, function name is <os>_tasks
  # eg darwin_tasks for mac
  local -r os_func="${OS,,}_tasks"
  if [[ "$(type -t ${os_func})" == "function" ]]; then
    ${os_func}
  else
    log "No os-specific tasks defined for ${OS}"
  fi
}

darwin_tasks() {
  log "Running Darwin(Mac)-specific tasks"
  setup_sublime_text_prefs
}

setup_sublime_text_prefs() {
  local -r datestamp=$(date '+%Y%m%d%H%M%S')
  local -r sublime_prefs_src="${DOTDIR}/SublimeText/User"
  local -r sublime_prefs_base=~/"Library/Application Support/Sublime Text 3/Packages"
  local -r sublime_prefs_dst="${sublime_prefs_base}/User"
  local -r sublime_prefs_backup="${sublime_prefs_dst}.bak.${datestamp}"

  log "Linking Sublime Text preferences"

  if [[ -L "${sublime_prefs_dst}" ]]; then
    log "Removing existing Sublime Text user prefs link at ${sublime_prefs_dst}"
    rm -f "${sublime_prefs_dst}"
  elif [[ -d "${sublime_prefs_dst}" ]]; then
    log "Existing Sublime Text user prefs dir found at ${sublime_prefs_dst}"
    log "Renaming to ${sublime_prefs_backup}"
    mv -f "${sublime_prefs_dst}" "${sublime_prefs_backup}"
  else
    log "Ensuring ${sublime_prefs_base} exists"
    mkdir -p "${sublime_prefs_base}"
  fi
  ln -sf "${sublime_prefs_src}" "${sublime_prefs_dst}"
}


main() {
  log "Dotfiles bootstrap"
  if [[ ${1:-} != noclone ]]; then
    move_existing_dotfiles
    clone_fresh_dotfiles
  fi
  setup_zsh
  setup_config
  use_zsh
  install_powerline
  viminit
  os_specific_tasks
}


main "$@"

# vim: ft=sh sts=2 ts=2 sw=2 expandtab
