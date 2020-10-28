# download and install openssh-server
echo "Installing OpenSSH Server ..."
sudo apt-get -y install openssh-server
sudo ufw allow openssh
