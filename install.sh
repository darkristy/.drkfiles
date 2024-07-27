#!/usr/bin/env bash

os_type="$(uname -s)"

universal_packages="zsh neovim tmux volta hub stow antidote starship peco rustup lazygit"
universal_programs="visual-studio-code alacritty"
macos_programs="raycast"
rust_crates="eza"

node_packages="neovim typescript rimraf ts-node commitizen @fsouza/prettierd vercel nodemon rollup"

function install_packages() {
  packages=$1
  manager=$2

  if [ "${manager}" == "brew" ]; then
    brew list | grep -E "${packages// /|}" >>/dev/null || brew install ${packages}
  else
    volta list | grep -E "${packages// /|}" >>/dev/null || volta install ${packages}
  fi

}

if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing packages and programs via Homebrew..."
if [ "${os_type}" == "Darwin" ]; then
  install_packages "${universal_packages} ${universal_programs} ${macos_programs}" "brew"
else
  install_packages "${universal_packages} ${universal_programs}" "brew"
fi

echo "Creating an SSH key for you..."
ssh-keygen -t ed25519 -C "darkristy2002@gmail.com"
touch ~/.ssh/config

echo "
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
" >>~/.ssh/config

ssh-add --apple-use-keychain ~/.ssh/id_ed25519

gh auth login
gh ssh-key add ~/.ssh/id_ed25519.pub -t github

echo "Setting up Node"
if test ! "$(which node)"; then
  volta install node
  echo "Installing bun..."
  volta install bun
fi

log "Installing global node packages"
install_packages "${node_packages}" "volta"

echo "Installing Rust..."
rustup-init

echo "Installing global rust crates..."
cargo install "${rust_crates}"

echo "Setting up shell..."
echo "Changing Shell to Homebrew ZSH"

if ! [ "$SHELL" == "$(which zsh)" ]; then
  echo "Checking if Homebrew zsh path is registered..."

  sudo grep -xqFe "$(which zsh)" /etc/shells || log "Registering zsh path ..." && sudo sh -c "echo $(which zsh) >> /etc/shells"

  chsh -s "$(which zsh)"
fi

if [ "${os_type}" == "Darwin" ]; then
  echo "export ZDOTDIR=$HOME/.config/zsh" >>~/.zprofile
else
  echo "export ZDOTDIR=$HOME/.config/zsh" >>~/.profile
fi

log "Stowing dotfiles"
stow zsh
stow git
stow nvim
stow tmux
stow starship
stow alacritty

echo "Bundling zsh plugins using antidote..."
antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh

echo "Installing Geist Mono Nerdfont"
brew install font-geist-mono-nerd-font
