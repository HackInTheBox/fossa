echo "Installing additional utilities ..."

#List additional packages here that do not require additional configurations to be automatically installed

extrapkgs=(
curl
tasksel
fail2ban
net-tools
)

sudo apt-get -y install ${extrapkgs[@]}
