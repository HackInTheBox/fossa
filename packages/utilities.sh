# List extra packages you want to install here.  
# If you need extra config, just create a separate script
extrapkgfunct() {
echo "Installing additional utilities ..."
#################################
# List additional packages here 
#################################
extrapkgs=(
curl
tasksel
fail2ban
net-tools
apparmor
apparmor-utils
apparmor-profiles
apparmor-profiles-extra
apparmor-notify
apparmor-easyprof
)
#################################
# List additional packages above 
#################################
sudo apt-get -y install ${extrapkgs[@]}
}
extrapkgfunct | tee -a "$LOGFIL"
