clear
echo '##############################'
echo '#                            #'
echo "#   Nikhil's Manjaro Setup   #"
echo '#                            #'
echo '##############################'

echo ''
echo 'What shall be done?'

echo ''
echo 'Update System?'
read do_update

echo ''
echo 'Create Dotfiles and symlinks?'
read do_symlinks

echo ''
echo 'Create folder for screenshots?'
read do_screenshot_folder

echo ''
echo 'Download base16-shell?'
read base_16

echo ''
echo 'Create temp folder?'
read temp_folder

echo ''
echo 'Build vim?'
read do_vim

echo ''
echo 'Install yay?'
read do_yay

echo ''
echo 'Install Software?'
read do_software

echo ''
echo 'Get LaTeX?'
read do_latex

echo ''
echo 'Install nodejs, npm, ruby etc.?'
read do_dev_software

echo 'All clear!'

if [[ $do_update == y* ]]; then
  sudo pacman-db-upgrade && sync
  sudo pacman -Syu
fi

if [ ! -d ~/Dotfiles ]; then
	if [[ $do_symlinks == y* ]]; then
		mkdir ~/Dotfiles
		mkdir ~/defaultBackups
		git clone git@github.com:realestninja/Dotfiles.git ~/Dotfiles

		echo 'Creating symlinks:'

		# to do: bashrc
		ln -s ~/Dotfiles/vim/.vimrc ~
		echo '.vimrc done'

		ln -s ~/Dotfiles/alsa/.asoundrc ~
		echo '.asoundrc done'

		ln -s ~/Dotfiles/profile/.profile ~
		echo '.profile done'

		mv ~/.Xresources ~/defaultBackups
		ln -s ~/Dotfiles/Xresources/.Xresources ~
		echo '.Xresources done'

		mv ~/.i3/config ~/defaultBackups/config_i3
		ln -s ~/Dotfiles/i3config/config ~/.i3/config
		echo 'i3 config done'

		sudo ln -s ~/Dotfiles/i3config/create_i3_config.sh /usr/local/bin/create_i3_config
		echo 'create_i3_config done'
		sudo chmod a+x /usr/local/bin/create_i3_config
		echo 'chmod a+x has been applied'
	fi
fi

if [ ! -d ~/Pictures/Screenshots ]; then
	if [[ $do_screenshot_folder == y* ]]; then
		mkdir ~/Pictures/Screenshots
	fi
fi

if [[ $base_16 == y* ]]; then
	git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

if [ ! -d ~/temp ]; then
	if [[ $temp_folder == y* ]]; then
		mkdir ~/temp
	fi
fi

if [ ~/temp ]; then
	if [[ $do_vim == y* ]]; then
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

	if [[ $do_yay == y* ]]; then
		cd ~/temp
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ~
	fi
fi

if [[ $do_software == y* ]]; then
  sudo pacman -S --noconfirm neofetch
  sudo pacman -S --noconfirm feh
  sudo pacman -S --noconfirm cowsay
  sudo pacman -S --noconfirm fortune-mod
  sudo pacman -S --noconfirm xclip
  sudo pacman -S --noconfirm clementine
  sudo pacman -S --noconfirm gthumb
  sudo pacman -S --noconfirm filezilla
  sudo pacman -S --noconfirm tmux
  sudo pacman -S --noconfirm telegram-desktop
  sudo pacman -S --noconfirm unzip
  sudo pacman -S --noconfirm zip
  sudo pacman -S --noconfirm unrar
  sudo pacman -S --noconfirm timeshift
  sudo pacman -S --noconfirm thunderbird
  sudo pacman -S --noconfirm tk #fixes gitk
  yay -S --noconfirm xcursor-dmz
  yay -S --noconfirm google-chrome
  yay -S --noconfirm spotify
  yay -S --noconfirm unimatrix-git
  yay -S --noconfirm slack-desktop
fi

if [[ $do_latex == y* ]]; then
  sudo pacman -S --noconfirm texlive-most texlive-lang
fi

if [[ $do_dev_software == y* ]]; then
  sudo pacman -S --noconfirm nodejs
  sudo pacman -S --noconfirm npm
  sudo npm i -g eslint
  sudo pacman -S --noconfirm ruby
  sudo pacman -S --noconfirm lua51
fi

echo ''
echo 'All done.'
