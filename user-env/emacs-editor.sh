#!/bin/sh

set -eux

. ./machine/local-env


cat <<-'EOF' > /etc/apt/preferences.d/backports-emacs
	Package: src:emacs
	Pin: release n=trixie-backports
	Pin-Priority: 500
	EOF

if \
  [ "${HOSTNAME}" = "voskhod" ] || \
  [ "${HOSTNAME}" = "molniya" ] || \
  [ "${HOSTNAME}" = "salyut" ]
then
  apt install --yes emacs-nox
else
  apt install --yes emacs-pgtk

  run_as_local_user <<'EOUSERSCRIPT'
    systemctl --user enable emacs.service
EOUSERSCRIPT
fi


ln -sfT "${DOTFILESDIR}/emacs" "/root/.config/emacs"

run_as_local_user <<'EOUSERSCRIPT'
  ln -sfT "${DOTFILESDIR}/emacs" "${HOME}/.config/emacs"
EOUSERSCRIPT
