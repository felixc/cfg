#!/bin/zsh

set -eux


. ./machine/local-env

run_as_local_user <<'EOUSERSCRIPT'

files=(aspell.en.pws caffrc ledgerrc nethackrc psqlrc signature \
       quiltrc vimrc XCompose xscreensaver)
for file in ${files}; do
  ln -sfT "${DOTFILESDIR}/${file}" "${HOME}/.${file}"
done

mkdir -p "${HOME}/.config"
files=(user-dirs.dirs git gtk-3.0 lbdb)
for file in ${files}; do
  ln -sfT "${DOTFILESDIR}/${file}" "${HOME}/.config/${file}"
done

mkdir -p "${HOME}/.config/fontconfig"
ln -sfT "${DOTFILESDIR}/fonts.conf" "${HOME}/.config/fontconfig/fonts.conf"

mkdir -p "${HOME}/.config/tmux"
ln -sfT "${DOTFILESDIR}/tmux.conf" "${HOME}/.config/tmux/tmux.conf"

mkdir -p "${HOME}/.caff/gnupghome"
ln -sfT "${DOTFILESDIR}/gnupg/gpg.conf" "${HOME}/.caff/gnupghome/gpg.conf"

mkdir -p "${HOME}/.gnupg"
ln -sfT "${DOTFILESDIR}/gnupg/gpg.conf" "${HOME}/.gnupg/gpg.conf"
ln -sfT "${DOTFILESDIR}/gnupg/scdaemon.conf" "${HOME}/.gnupg/scdaemon.conf"
ln -sfT "${DOTFILESDIR}/gnupg/gpg-agent.conf" "${HOME}/.gnupg/gpg-agent.conf"
find "${HOME}/.gnupg/" -type f -exec chmod 600 '{}' \;
find "${HOME}/.gnupg/" -type d -exec chmod 700 '{}' \;

mkdir -p "${HOME}/.ipython/profile_default/"
ln -sfT "${DOTFILESDIR}/ipython_config.py" "${HOME}/.ipython/profile_default/ipython_config.py"

mkdir -p "${HOME}/.ssh"
ln -sfT "${DOTFILESDIR}/ssh" "${HOME}/.ssh/config"

moz_profile_dir=$(find "${HOME}/.mozilla/firefox" -name "*.default-beta" -type d 2> /dev/null || echo "")
if [ -n "${moz_profile_dir}" ]; then
    mkdir -p "${moz_profile_dir}/chrome"
    ln -sfT "${DOTFILESDIR}/firefox/user.js" "${moz_profile_dir}/user.js"
    ln -sfT "${DOTFILESDIR}/firefox/userContent.css" "${moz_profile_dir}/chrome/userContent.css"
    ln -sfT "${DOTFILESDIR}/firefox/userChrome.css" "${moz_profile_dir}/chrome/userChrome.css"
fi

EOUSERSCRIPT
