#!/usr/bin/env bash

set -eu

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: " "$@" >&2
}

log() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: " "$@" >&1
}

: ${DOTDIR:=~/.dotfiles}
: ${DOTREPO:="https://github.com/bmoyles/dotfiles.git"}
: ${OS:=$(uname -s)}
readonly DOTDIR DOTREPO OS


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

zsh_over_bash() {
  local -r datestamp=$(date '+%Y%m%d%H%M%S')
  local -r bash_profile=~/.bash_profile
  local -r bash_profile_backup=${bash_profile}.bak.${datestamp}

  PATH=/usr/local/bin:/usr/bin:/bin
  if which zsh > /dev/null; then
    ZSH_PATH=$(which zsh)
    if [[ -e ${bash_profile} ]]; then
      log "Existing bash_profile ${bash_profile} found"
      if [[ -L ${bash_profile} ]]; then
        log "${bash_profile} is a symlink, removing"
        rm -f "${bash_profile}"
      else
        log "Renaming existing ${bash_profile} to ${bash_profile_backup}"
        mv -f ${bash_profile} ${bash_profile_backup}
      fi
    fi
    log "Writing bash_profile to enable zsh w/o chsh"
    cat <<EOF > ${bash_profile}
if [[ -z "\${NO_ZSH}" ]]; then
  export SHELL=${ZSH_PATH}
  exec ${ZSH_PATH} -d -l
fi
EOF
  else
    err "zsh not found on path ${PATH}"
  fi
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
  move_existing_dotfiles
  clone_fresh_dotfiles
  setup_zsh
  setup_config
  zsh_over_bash
  os_specific_tasks
}


main "$@"

# vim: ft=sh sts=2 ts=2 sw=2 expandtab