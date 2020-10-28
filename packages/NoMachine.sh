# download and install 'NoMachine"
echo "Installing NoMachine ..."
DOWNLO="$HOME/Downloads"
mkdir -p "$DOWNLO"
cd "$DOWNLO"
wget -nv https://download.nomachine.com/download/6.11/Linux/nomachine_6.11.2_1_amd64.deb
sudo apt-get -y install "${DOWNLO}/nomachine_6.11.2_1_amd64.deb"
sudo ufw allow 4000
