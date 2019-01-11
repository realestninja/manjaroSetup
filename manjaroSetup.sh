clear
echo '##############################'
echo '#                            #'
echo "#   Nikhil's Manjaro Setup   #"
echo '#                            #'
echo '##############################'

echo ''
echo 'Update System?'
read answer
if [[ $answer == y* ]]; then
  sudo pacman-db-upgrade && sync
  sudo pacman -Syu
fi


if [ ! -d ~/Dotfiles ]; then
	echo ''
	echo 'Create Dotfiles and symlinks?'
	read answer
	if [[ $answer == y* ]]; then
		mkdir ~/Dotfiles
		mkdir ~/defaultBackups
		git clone git@github.com:realestninja/Dotfiles.git ~/Dotfiles

		ln -s ~/Dotfiles/vim/.vimrc ~
		ln -s ~/Dotfiles/alsa/.asoundrc ~
		ln -s ~/Dotfiles/profile/.profile ~

		mv ~/.Xresources ~/defaultBackups
		ln -s ~/Dotfiles/Xresources/.Xresources ~
	fi
fi

if [ ! -d ~/Pictures/Screenshots ]; then
	echo ''
	echo 'Create folder for screenshots?'
	read answer
	if [[ $answer == y* ]]; then
		mkdir ~/Pictures/Screenshots
	fi
fi

echo ''
echo 'Download base16-shell?'
read answer
if [[ $answer == y* ]]; then
	mkdir ~/Dotfiles
	git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

if [ ! -d ~/temp ]; then
	echo ''
	echo 'Create temp folder?'
	read answer
	if [[ $answer == y* ]]; then
		mkdir ~/temp
	fi
fi


echo ''
echo 'Install Software?'
read answer
if [[ $answer == y* ]]; then
  sudo pacman -S neofetch
  sudo pacman -S feh
  sudo pacman -S texlive-most texlive-lang
  sudo pacman -S cowsay
  sudo pacman -S fortune-mod
  sudo pacman -S xclip
  sudo pacman -S clementine
  sudo pacman -S gthumb
  sudo pacman -S filezilla
  sudo pacman -S tmux
  sudo pacman -S telegram-desktop
  sudo pacman -S unzip
  sudo pacman -S zip
  sudo pacman -S unrar
fi



if [ ~/temp ]; then
	echo ''
	echo 'Build vim?'
	read answer
	if [[ $answer == y* ]]; then
		sudo pacman -R vim
		cd ~/temp/
		git clone --depth 1 https://github.com/vim/vim.git
		cd vim
		./configure --with-features=huge \
			      --enable-multibyte \
			      --enable-rubyinterp=yes \
			      --enable-pythoninterp=yes \
			      --enable-python3interp=yes \
			      --with-python3-config-dir=/usr/lib/python3.5/config-3.6m-x86_64-linux-gnu \
			      --enable-perlinterp=yes \
			      --enable-luainterp=yes \
			      --enable-gui=gtk2 --enable-cscope --prefix=/usr
		make VIMRUNTIMEDIR=/usr/share/vim/vim81
		sudo make install
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	fi

	echo ''
	echo 'Install latest Google Chrome?'
	read answer
	if [[ $answer == y* ]]; then
		cd ~/temp
		git clone https://aur.archlinux.org/google-chrome.git
		cd google-chrome/
		makepkg -s
		sudo pacman -U --noconfirm google-chrome*.tar.xz
		cd ~
	fi

	echo ''
	echo 'Install Spotify?'
	read answer
	if [[ $answer == y* ]]; then
		cd ~/temp
		git clone https://aur.archlinux.org/spotify.git
		cd spotify
		makepkg -s
		sudo pacman -U --noconfirm spotify*.tar.xz
		cd ~
	fi

	echo ''
	echo 'Install Unimatrix?'
	read answer
	if [[ $answer == y* ]]; then
		cd ~/temp
		git clone https://aur.archlinux.org/unimatrix-git.git
		cd unimatrix-git/
		makepkg -s
		sudo pacman -U --noconfirm unimatrix-git*.tar.xz
		cd ~
	fi
fi


echo ''
echo "Install Developer's Software?"
read answer
if [[ $answer == y* ]]; then
  sudo pacman -S nodejs
  sudo pacman -S npm
  sudo pacman -S ruby
  sudo pacman -S lua51
fi

echo ''
echo 'Install Global Node Modules?'
read answer
if [[ $answer == y* ]]; then
  sudo npm i -g eslint
fi

echo ''
echo 'Create ssh key?'
read answer
if [[ $answer == y* ]]; then
	read email
	ssh-keygen -t rsa -b 4096 -C "$email"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
	xclip -sel clip < ~/.ssh/id_rsa.pub
	xdg-open https://github.com/settings/keys
fi

echo ''
echo 'All done.'
