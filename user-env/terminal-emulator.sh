#!/bin/sh

set -eux

. ./machine/local-env


apt install --yes kitty

update-alternatives --set x-terminal-emulator "$(which kitty)"


run_as_local_user <<'EOUSERSCRIPT'

gsettings set org.cinnamon.desktop.default-applications.terminal exec "${HOME}/bin/t"

mkdir -p "${HOME}/.config/kitty"
ln -sfT "${DOTFILESDIR}/kitty.conf" "${HOME}/.config/kitty/kitty.conf"

EOUSERSCRIPT
