#!/bin/bash

echo "\n install zsh + oh-my-zsh (part 2) \n"
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
echo "source ${PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

echo "\n install tmux and plugin manager \n"
sudo apt install tmux -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "\n install latest version of vim and vim-plug \n"
sudo add-apt-repository ppa:jonathonf/vim -y
sudo apt update -y
sudo apt install vim -y
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install node to coc.nvim plugin
curl -sL install-node.vercel.app/lts | bash

echo "\n download dots files from git \n"
mkdir Projects && cd Projects
git clone https://github.com/AugustoCL/dots.git && cd dots
ln -sf ~/Projects/dots/.bashrc ~/.bashrc
ln -sf ~/Projects/dots/.zshrc ~/.zshrc
ln -sf ~/Projects/dots/.vimrc ~/.vimrc
ln -sf ~/Projects/dots/.tmux.conf ~/.tmux.conf

echo "\n add vlc \n"
sudo apt install vlc -y

echo "\n add programming languages (Julia, Rust) \n"
# julia
sudo bash -ci "$(curl -fsSL https://raw.githubusercontent.com/abelsiqueira/jill/main/jill.sh)"
# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
