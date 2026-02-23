#!/bin/sh

set -eux

. ./machine/local-env


chsh --shell "$(which zsh)"
chsh --shell "$(which zsh)" "${LOCAL_USERNAME}"


ln -sfT "${DOTFILESDIR}/zshrc" /root/.zshrc

run_as_local_user <<'EOUSERSCRIPT'
  ln -sfT "${DOTFILESDIR}/zshenv" "${HOME}/.zshenv"
  ln -sfT "${DOTFILESDIR}/zshrc" "${HOME}/.zshrc"
EOUSERSCRIPT
