#!/bin/bash

#
# will be run by https://github.com/MikeMcQuaid/strap when attempting to configure dotfiles
#

echo "Running ${HOME}/.dotfiles/script/bootstrap ..."

# ./script/bootstrap || exit 1

mkdir -p ${HOME}/git/personal
pushd "${HOME}/git/personal" || exit 1
if [[ ! -d "${HOME}/git/personal/rick" ]]; then
  echo
  echo "Cloning personal repositories ..."
  curl -s https://api.github.com/users/rick/repos | grep \"clone_url\" | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g' | xargs -n1 git clone
fi
popd || exit 1

echo "Setting up asdf ..."
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add postgres
asdf plugin-add direnv
asdf direnv setup --shell bash --version system

echo "Installing ruby versions ..."
"${HOME}"/bin/install-rubies || exit 1
