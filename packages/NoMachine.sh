# download and install 'NoMachine"
nomachi() {
echo "Installing NoMachine ..."
mkdir -p "$DOWNLO"
cd "$DOWNLO"
wget -nv https://download.nomachine.com/download/6.11/Linux/nomachine_6.11.2_1_amd64.deb
sudo apt-get -y install ./nomachine_6.11.2_1_amd64.deb
sudo ufw allow 4000
}
nomachi | tee -a "$LOGFIL"
