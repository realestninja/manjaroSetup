clear
echo '##############################'
echo '#                            #'
echo "#   Nikhil's Manjaro Setup   #"
echo '#                            #'
echo '##############################'
echo '#                            #'
echo "#         PreScript          #"
echo '#                            #'
echo '##############################'

echo 'xclip required. Downloading now.'
sudo pacman -S xclip

echo 'Enter E-Mail adress'
read email
echo 'Enter user.name'
read name

echo 'Setting git global credentials:'
git config --global user.email "$email"
git config --global user.name "$name"
echo 'Done.'

echo 'Creating SSH-Key'
ssh-keygen -t rsa -b 4096 -C "$email"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

xclip -sel clip < ~/.ssh/id_rsa.pub
echo 'Done.'

echo 'Add to github. Redirecting now.'
xdg-open https://github.com/settings/keys
