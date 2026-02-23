#!/bin/sh

set -eux


. ./machine/local-env

run_as_local_user <<'EOUSERSCRIPT'

mkdir -p "${HOME}/.config"
ln -sfT "${DOTFILESDIR}/gtk-3.0" "${HOME}/.config/gtk-3.0"


gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-key-theme 'Emacs'
gsettings set org.gnome.desktop.interface overlay-scrolling false

EOUSERSCRIPT
