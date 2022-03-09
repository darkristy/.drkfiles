#!/usr/bin/env bash

os_type="$(uname -s)"

universal_packages="zsh stylua rustup black shfmt shellcheck stow antibody gh lua tmux starship neovim volta peco rust-analyzer hub exa visual-studio-code"
mac_packages="cocoapods watchman iterm2 watson cleanmymac alfred rectangle imageoptim fig"

node_packages="vscode-langservers-extracted neovim typescript rimraf ts-node commitizen @fsouza/prettierd vercel nodemon rollup"

bold="$(tput bold 2>/dev/null || printf '')"
grey="$(tput setaf 0 2>/dev/null || printf '')"
underline="$(tput smul 2>/dev/null || printf '')"
red="$(tput setaf 1 2>/dev/null || printf '')"
green="$(tput setaf 2 2>/dev/null || printf '')"
yellow="$(tput setaf 3 2>/dev/null || printf '')"
blue="$(tput setaf 4 2>/dev/null || printf '')"
magenta="$(tput setaf 5 2>/dev/null || printf '')"
no_color="$(tput sgr0 2>/dev/null || printf '')"

printf "\n"

log() {
	printf '%s\n' "${blue}> $*${no_color}"
}

function install_packages() {
	packages=$1
	manager=$2

	if [ "${manager}" == "brew" ]; then
		brew list | grep -E "${packages// /|}" >>/dev/null || brew install ${packages}
	else
		volta list | grep -E "${packages// /|}" >>/dev/null || yarn global add ${packages}
	fi

}

# log "Creating an SSH key for you..."
# ssh-keygen -t rsa
#
# log "Please add this public key to Github \n"
# log "https://github.com/account/ssh \n"
# read -pr "Press [Enter] key after this..."
#
if [ "${os_type}" == "Darwin" ]; then
	log "Installing xcode-stuff"
	xcode-select --install
fi

if test ! "$(which brew)"; then
	log "Homebrew is not installed, installing now"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

log "Updating homebrew..."
brew update

log "Installing Homebrew Packages"

if [ "${os_type}" == "Darwin" ]; then
	install_packages "${universal_packages} ${mac_packages}" "brew"
else
	install_packages "${universal_packages}" "brew"
fi

log "Cleaning up brew"
brew cleanup

log "Setting up Node"

if test ! "$(which yarn)"; then
	log "Installing yarn via volta"
	volta install node
	volta install yarn
fi

log "Installing global node packages"

install_packages "${node_packages}" "yarn"

log "Setting up shell..."
log "Changing Shell to Homebrew ZSH"

if ! [ "$SHELL" == "$(which zsh)" ]; then
	log "Checking if Homebrew zsh path is registered..."

	sudo grep -xqFe "$(which zsh)" /etc/shells || log "Registering zsh path ..." && sudo sh -c "echo $(which zsh) >> /etc/shells"

	chsh -s "$(which zsh)"
fi

log "Stowing dotfiles"

stow zsh
stow git
stow tmux
stow starship

# if [ "${os_type}" == "Darwin" ]; then
# 	stow zprofile
# else
# 	echo "export ZDOTDIR=$HOME/.config/zsh" >>~/.profile
# fi

log "Bundling zsh plugins"

antibody bundle <~/.zsh_plugins.txt >~/.zsh_plugins.sh

log "Done!"
