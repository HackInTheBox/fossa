# download and install 'NoMachine"

nomachi() {
cd "$DOWNLO"

# Download Nomachine HTML download page to temp file
wget -nv -O ./nomachine.temp "https://www.nomachine.com/download/download&id=2"

# Scrape the latest version and actual download link
# As long as the above download page stays the same, this code will automatically get the latest version
targetfile="$(cat ./nomachine.temp | grep -E -o 'https(.*)deb')"

# Remove temp html file
rm ./nomachine.temp

# Download latest version
wget -nv "$targetfile"

# Install
packagename="$(basename $targetfile)"
sudo apt -y install ./"$packagename"

# Allow incoming connections on firewall
sudo ufw allow 4000

}
nomachi | tee -a "$LOGFIL"
