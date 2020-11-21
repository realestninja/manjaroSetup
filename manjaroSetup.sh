clear
echo '##############################'
echo '#                            #'
echo "#   Nikhil's Manjaro Setup   #"
echo '#                            #'
echo '##############################'

sudo ufw enable
echo ''
echo 'Uncomplicated Firewall activated'

echo ''
echo 'What shall be done?'

echo ''
echo 'Create Dotfiles and symlinks?'
read do_symlinks

echo ''
echo 'Create folders for screenshots and lockscreen?'
read do_screenshot_folder

echo ''
echo 'Download base16-shell?'
read base_16

echo ''
echo 'Create temp folder?'
read temp_folder

echo ''
echo 'Download favourite Nerd Fonts?'
read nerdfonts

echo ''
echo 'Build vim?'
read do_vim

echo ''
echo 'Install yay?'
read do_yay

echo ''
echo 'Install Software?'
read do_software

# echo ''
# echo 'Install nitroshare?'
# read do_nitroshare

# echo ''
# echo 'Get LaTeX?'
# read do_latex

echo ''
echo 'Install nodejs, npm, ruby etc.?'
read do_dev_software

echo 'Get Vimium for Google Chrome?'
read do_vimium

echo 'All clear!'

if [ ! -d ~/Dotfiles ]; then
	if [[ $do_symlinks == y* ]]; then
		mkdir ~/Dotfiles
		mkdir ~/Code
		mkdir ~/defaultBackups
		git clone git@github.com:realestninja/Dotfiles.git ~/Dotfiles

		echo 'Creating symlinks:'

		rm ~/.bashrc
		ln -s ~/Dotfiles/bash/.bashrc ~
		source ~/.bashrc
		echo '.bashrc done'
		ln -s ~/Dotfiles/bash/.bash_aliases ~
		echo '.bash_aliases done'
		ln -s ~/Dotfiles/bash/.bash_machine ~
		echo '.bash_machine done'

		cp ~/Dotfiles/git/user.gitconfig.example ~/Dotfiles/git/user.gitconfig
		rm ~/.gitconfig
		ln -s ~/Dotfiles/git/.gitconfig ~
		echo '.gitconfig done'

		ln -s ~/Dotfiles/bash/.git-completion.bash ~
		echo '.git-completion.bash done'

		ln -s ~/Dotfiles/kitty/kitty.conf ~/.config/kitty/
		echo '.kitty done'

		ln -s ~/Dotfiles/vim/.vimrc ~
		echo '.vimrc done'

		ln -s ~/Dotfiles/fontconfig/font.conf ~/.config/font.conf
		echo 'font.conf done'

		#ln -s ~/Dotfiles/vim/coc-settings.json ~/.vim/coc-settings.json
		#echo 'coc-settings.json done'

		#ln -s ~/Dotfiles/alsa/.asoundrc ~
		#echo '.asoundrc done'

		#mv ~/.Xresources ~/defaultBackups
		#ln -s ~/Dotfiles/Xresources/.Xresources ~
		#echo '.Xresources done'

		#mkdir ~/.config/polybar
		#ln -s ~/Dotfiles/polybar/config ~/.config/polybar
		#echo 'polybar config done'

		mv ~/.i3/config ~/defaultBackups/config_i3
		ln -s ~/Dotfiles/i3config/i3.config ~/.i3/config
		echo 'i3 config done'

		mv ~/.config/ranger/rc.conf ~/defaultBackups/rc.conf
		ln -s ~/Dotfiles/ranger/rc.conf
		echo 'ranger config done'

		ln -s ~/Dotfiles/git/.gitconfig ~/.gitconfig
		cp ~/Dotfiles/git/user.gitconfig.example ~/Dotfiles/git/user.gitconfig
		ln -s ~/Dotfiles/git/user.gitconfig ~/user.gitconfig
		echo 'git config done'

		#rm ~/.profile
		#ln -s ~/Dotfiles/profile/.profile ~/.profile
		#echo 'profile done'

		sudo ln -s ~/Dotfiles/i3config/create_i3_config.sh /usr/local/bin/create_i3_config
		echo 'create_i3_config done'
		sudo chmod a+x /usr/local/bin/create_i3_config
		echo 'chmod a+x has been applied'

		sudo sh ~/Dotfiles/make_scriptcollection_global.sh
		echo 'Available scripts are now global'

		mkdir ~/OnePlus
	fi
fi

if [ ! -d ~/Pictures/Screenshots ]; then
	if [[ $do_screenshot_folder == y* ]]; then
		mkdir ~/Pictures/Screenshots
		mkdir ~/Pictures/Lockscreen
		touch ~/Pictures/Lockscreen/lockscreen.png
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

if [[ $nerdfonts == y* ]]; then
	mkdir ~/Downloads/fonts
	wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/M/Regular/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.ttf -P ~/Downloads/fonts
	sudo cp ~/Download/fonts/*.ttf /usr/share/fonts/TTF/
	sudo cp ~/Download/fonts/*.otf /usr/share/fonts/OTF/
	fc-cache
fi

if [ ~/temp ]; then
	if [[ $do_vim == y* ]]; then
		sudo pacman -R vim
		cd ~/temp/
		git clone --depth 1 https://github.com/vim/vim.git
		echo "--------------------"
		echo "Python path example:"
		echo "/usr/lib/python3.8/config-3.8-x86_64-linux-gnu"
		echo "Latest python path?"
		read pyth_path
		echo "Latest vim version? (Example: 82)"
		read vim_version
		cd vim
		./configure --with-features=huge \
			      --enable-multibyte \
			      --enable-rubyinterp=yes \
			      --enable-pythoninterp=yes \
			      --enable-python3interp=yes \
			      --with-python3-config-dir=$pyth_path \
			      --enable-perlinterp=yes \
			      --enable-luainterp=yes \
			      --enable-gui=gtk2 --enable-cscope --prefix=/usr
		make VIMRUNTIMEDIR=/usr/share/vim/vim$vim_version
		sudo make install
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
		vim +PluginInstall +qall
	fi

	if [[ $do_yay == y* ]]; then
		cd ~/temp
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ~
	fi

	# if [[ $do_nitroshare == y* ]]; then
		# cd ~/temp
		# wget https://aur.archlinux.org/cgit/aur.git/snapshot/nitroshare.tar.gz
		# tar xf nitroshare.tar.gz
		# cd nitroshare
		# makepkg -sri
		# cd ~
	# fi
fi

if [[ $do_software == y* ]]; then
  sudo pacman -S --noconfirm ranger
  sudo pacman -S --noconfirm rofi
  sudo pacman -S --noconfirm manjaro-settings-manager
  sudo pacman -S --noconfirm keychain
  sudo pacman -S --noconfirm kitty
  sudo pacman -S --noconfirm pulseaudio
  sudo pacman -S --noconfirm neofetch
  sudo pacman -S --noconfirm feh
  sudo pacman -S --noconfirm scrot
  sudo pacman -S --noconfirm flameshot
  sudo pacman -S --noconfirm cowsay
  sudo pacman -S --noconfirm fortune-mod
  sudo pacman -S --noconfirm xclip
  sudo pacman -S --noconfirm clementine
  sudo pacman -S --noconfirm gthumb
  sudo pacman -S --noconfirm filezilla
  sudo pacman -S --noconfirm tmux
  sudo pacman -S --noconfirm fzf
  sudo pacman -S --noconfirm diff-so-fancy
  sudo pacman -S --noconfirm the_silver_searcher
  sudo pacman -S --noconfirm telegram-desktop
  sudo pacman -S --noconfirm unzip
  sudo pacman -S --noconfirm zip
  sudo pacman -S --noconfirm unrar
  sudo pacman -S --noconfirm timeshift
  sudo pacman -S --noconfirm thunderbird
  sudo pacman -S --noconfirm tk #fixes gitk
  sudo pacman -S --noconfirm polybar
  sudo pacman -S --noconfirm udevil
  sudo pacman -S --noconfirm playerctl
  sudo pacman -S --noconfirm unclutter
  sudo pacman -R --noconfirm palemoon-bin
  sudo pacman -S --noconfirm youtube-dl
  sudo pacman -S --noconfirm simplescreenrecorder
  sudo pacman -S --noconfirm ntp && sudo timedatectl set-ntp true
  sudo pacman -S --noconfirm ncdu
  yay -S --noconfirm protonvpn-cli-ng
  yay -S --noconfirm xcursor-dmz
  yay -S --noconfirm google-chrome
  yay -S --noconfirm spotify
  yay -S --noconfirm unimatrix-git
  yay -S --noconfirm light-git
  yay -S --noconfirm rofi-emoji
  # yay -S --noconfirm slack-desktop
  # yay -S --noconfirm jmtpfs
  # yay -S --noconfirm gucharmap
  # yay -S --noconfirm xmeasure

  sudo pacman -S --noconfirm kdeconnect
  sudo ufw allow 1714:1764/udp
  sudo ufw allow 1714:1764/tcp
  sudo ufw reload
fi

# if [[ $do_latex == y* ]]; then
  # sudo pacman -S --noconfirm texlive-most texlive-lang
# fi

if [[ $do_dev_software == y* ]]; then
  sudo pacman -S --noconfirm nodejs
  sudo pacman -S --noconfirm npm
  sudo npm i -g n
  sudo npm i -g eslint
  sudo npm i -g stylelint
  yay -S --noconfirm ctags
  sudo pacman -S --noconfirm ruby
  sudo pacman -S --noconfirm lua51
fi

if [[ $do_vimium == y* ]]; then
  xdg-open https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb/related
fi

echo ''
echo 'All done.'
