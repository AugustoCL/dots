#!/bin/bash

echo "\n update and upgrade apt \n"
sudo apt-get update -y && sudo apt-get upgrade -y

echo "\n install git and essentials packages \n"
sudo apt install git -y
sudo apt install make gcc build-essential curl -y

echo "\n install some cli packages (exa, fzf, hyperfine, fd-find, xclip, bat, dust, btop-desktop \n"
sudo apt install exa fzf hyperfine fd-find xclip -y
sudo ln -s $(which fdfind) ~/.local/bin/fd
sudo apt install bat -y
mkdir -p ~/.local/bin
sudo ln -s /usr/bin/batcat ~/.local/bin/bat
sudo snap install dust btop-desktop

echo "\n installing flat-remix theme by gnome-tweaks \n"
git clone https://github.com/daniruiz/flat-remix
git clone https://github.com/daniruiz/flat-remix-gtk
mkdir -p ~/.icons && mkdir -p ~/.themes
cp -r flat-remix/Flat-Remix* ~/.icons/ && cp -r flat-remix-gtk/themes/Flat-Remix-GTK* ~/.themes/
sudo apt install gnome-tweaks fonts-hack-ttf -y

echo "\n adding juliamono font \n"
cd ~/Downloads && wget "https://github.com/cormullion/juliamono/releases/download/v0.050/JuliaMono-ttf.zip"
unzip JuliaMono-ttf.zip
sudo mv JuliaMono*.ttf /usr/share/fonts/truetype
cd ~

echo "\n install zsh + oh-my-zsh (part 1) \n"
sudo apt install zsh -y
