#!/usr/bin/env bash
set -eux -o pipefail

# fix permissions so Homebrew and Bundler don't complain
sudo chmod -R g-w,o-w /home/linuxbrew
sudo chmod +t -R /home/linuxbrew/

# everything below is too slow to do unless prebuilding so skip it
CODESPACES_ACTION_NAME="$(jq --raw-output '.ACTION_NAME' /workspaces/.codespaces/shared/environment-variables.json)"
if [[ "${CODESPACES_ACTION_NAME}" != "createPrebuildTemplate" ]]
then
  echo "Skipping slow items, not prebuilding."
  exit 0
fi

# install Homebrew's development gems
brew install-bundler-gems --groups=all

# install Homebrew formulae we might need
brew install shellcheck shfmt gh gnu-tar

# cleanup any mess
brew cleanup

# install some useful development things
sudo apt-get update

apt_get_install() {
  sudo apt-get install --yes --no-install-recommends \
    -o Dpkg::Options::=--force-confdef \
    -o Dpkg::Options::=--force-confnew \
    "$@"
}

apt_get_install \
  openssh-server \
  zsh

# Start the SSH server so that `gh cs ssh` works.
sudo service ssh start

# Enable developer mode
brew developer on

# Setup command
brew install starship
echo 'eval "$(starship init bash)"' >> /home/linuxbrew/.bashrc
